class Pet < ActiveRecord::Base
  include HTTParty

  ANIMAL_TYPES = %w(barnyard bird cat dog horse pig reptile smallfurry)
  AGES = %w(baby young adult senior)
  SEXES = %w(male female)
  SIZES = %w(small medium large extra-large)

  base_uri 'api.petfinder.com'
  format :json

  belongs_to :shelter
  has_many :faves
  has_many :users, through: :faves

  validates :animal_type, :name, presence: true
  validates :petfinder_id, uniqueness: true, allow_nil: true

  enum sex: SEXES
  enum age: AGES
  enum animal_type: ANIMAL_TYPES
  enum size: SIZES

  def self.find_by_breed(breed)
    get('/breed.list', query: { key: ENV['PETFINDER_API_KEY'], animal: breed, format: 'json' })
  end

  def self.find_by_single_pet(single_pet)
    get('/pet.get', query: { key: ENV['PETFINDER_API_KEY'], id: single_pet, format: 'json' })
  end

  def self.find_by_random(options)
    get('/pet.getRandom', query: { key: ENV['PETFINDER_API_KEY'], animal: options, reed:ptions, size: options, sex: options, location: options, shelterid: options, format: 'json' })
  end

  def self.find_by_criteria(pet_criteria)
    get('/pet.find', query: { key: ENV['PETFINDER_API_KEY'], animal: pet_criteria, breed: pet_criteria, size: pet_criteria, location: pet_criteria, age: pet_criteria, format: 'json' })
  end

  def self.find_by_shelter(shelter)
    get('/shelter.find', query: { key: ENV['PETFINDER_API_KEY'], location: shelter, name: shelter, format: 'json' })
  end

  def self.find_by_single_shelter(single_shelter)
    get('/shelter.get', query: { key: ENV['PETFINDER_API_KEY'], id: single_shelter, format: 'json' })
  end

  def self.find_by_pet_records_for_shelter(pet_ids)
    get('/shelter.getPets', query: {key: ENV['PETFINDER_API_KEY'], id: pet_ids, format: 'json' })
  end

  def self.find_by_shelter_list_breed(shelter_ids)
    get('/shelter.listByBreed', query: { key: ENV['PETFINDER_API_KEY'], animal: shelter_ids, breed: shelter_ids, format: 'json' })
  end
end
