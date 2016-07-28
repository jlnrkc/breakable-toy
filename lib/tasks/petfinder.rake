namespace :petfinder do
  desc "Imports shelters from Petfinder"
  task import_shelters: :environment do
    shelter_ids = [nil]
    last_offset = 0

    puts "Updating shelters…"
    while true
      # Make API request
      json = JSON.parse(HTTParty.get('http://api.petfinder.com/shelter.find', query: {
        key: ENV['PETFINDER_API_KEY'],
        location: 'MA',
        format: :json,
        count: 500,
        offset: last_offset
      }).body, symbolize_names: true)
      # Get shelters if any
      shelters = json[:petfinder].try(:[], :shelters).try(:[], :shelter)
      break if shelters.blank? # return if no shelters
      # Get only MA shelters
      relevant_shelters = shelters.select { |sh| sh[:state][:$t] == 'MA' }
      break if relevant_shelters.blank? # return if no MA shelters
      # Store latest offset for next request
      last_offset = json[:petfinder][:lastOffset][:$t].to_i
      # Save/update shelters
      relevant_shelters.each do |shelter|
        next if shelter[:id][:$t].blank?
        s = Shelter.find_or_initialize_by(petfinder_id: shelter[:id][:$t])
        begin
          s.name = shelter[:name][:$t]
          s.location = shelter.slice(:address1, :address2, :city, :state, :zip).map { |k, v| v[:$t] }.select(&:present?).join(", ")
          s.save!
          # Make note that this petfinder shelter was saved or updated
          shelter_ids << s.petfinder_id
        rescue => e
          puts e
        end
      end
    end
    puts "Added or updated #{shelter_ids.length - 1} shelters."

    # Delete shelters from Petfinder API that no longer appear in the API
    closed_shelters = Shelter.where.not(petfinder_id: shelter_ids)
    if closed_shelters.any?
      puts "Destroying #{closed_shelters.size} closed shelters…"
      closed_shelters.destroy_all
    end
  end

  desc "Imports pets from Petfinder"
  task import_pets: :environment do
    # Iterate through shelters and get pets
    pet_ids = [nil]
    pets = {}
    puts "Updating pets…"
    Shelter.where.not(petfinder_id: nil).each do |shelter|
      json = JSON.parse(HTTParty.get('http://api.petfinder.com/shelter.getPets', query: {
        key: ENV['PETFINDER_API_KEY'],
        format: :json,
        count: 500,
        id: shelter.petfinder_id
      }).body, symbolize_names: true)
      pets = json[:petfinder].try(:[], :pets).try(:[], :pet)
      next if pets.blank?
      pets = [pets] unless pets.is_a?(Array) # Handles one-pet scenario, which may give Hash
      pets.each do |pet|
        next if pet[:id].try(:[], :$t).blank?
        p = Pet.find_or_initialize_by(petfinder_id: pet[:id][:$t])
        begin
          p.shelter = shelter
          p.animal_type = pet[:animal][:$t].downcase.gsub(/[^a-z]/,'')
          p.breed = determine_breed(pet[:breeds][:breed])
          p.age = pet[:age][:$t].try(:downcase)
          p.sex = determine_sex(pet[:sex][:$t])
          p.size = determine_size(pet[:size][:$t])
          p.name = pet[:name][:$t]
          p.description = pet[:description][:$t]
          p.save!
          pet_ids << p.petfinder_id
        rescue => e
          puts e.message
        end
      end
    end
    puts "Added or updated #{pet_ids.length - 1} pets."

    # Delete pets from Petfinder API that no longer appear in the API
    adopted_pets = Pet.where.not(petfinder_id: pet_ids)
    if adopted_pets.any?
      puts "Destroying #{adopted_pets.size} adopted pets…"
      adopted_pets.destroy_all
    end
  end

  private

  def determine_sex(sex)
    case sex.downcase
    when "f", "female" then "female"
    when "m", "male" then "male"
    else nil
    end
  end

  def determine_size(size)
    case size.downcase
    when "s", "small" then "small"
    when "m", "medium" then "medium"
    when "l", "large" then "large"
    when "xl", "extra-large" then "extra-large"
    else nil
    end
  end

  def determine_breed(breed)
    if breed.is_a?(Array)
      breed.map { |b| b[:$t] }.join("/")
    else
      breed[:$t]
    end
  end
end
