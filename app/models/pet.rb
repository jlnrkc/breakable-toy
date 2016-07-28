require 'net/http'
require 'json'
require 'pry'
require 'pp'

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

#   KEY = '95c16e6439121fe454652ef459cb057e'
#
#   shelters = {}
#
#   def create_uri(offset, state)
#     uri = URI('http://api.petfinder.com/shelter.find')
#     params = {
#       key: KEY,
#       location: state,
#       format: :json,
#       count: 500,
#       offset: offset
#     }
#     uri.query = URI.encode_www_form(params)
#     uri
#   end
#
#   state = "MA"
#   last_offset = 0
#
#   puts "Fetching #{state}…"
#
#   while true
#     break unless response.is_a?(Net::HTTPSuccess)
#     json = parse(response.body, symbolize_names: true)
#     json_shelters = json[:petfinder] && json[:petfinder][:shelters] && json[:petfinder][:shelters][:shelter]
#     break if json_shelters.nil? || json_shelters.empty?
#     relevant_shelters = json_shelters.select { |sh| sh[:state][:$t] == state }
#     break if relevant_shelters.empty?
#     last_offset = json[:petfinder][:lastOffset][:$t].to_i
#     relevant_shelters.each_with_index do |sh, i|
#       puts "Shelter already existed: #{shelters[shelter[:name][:$t]]}" && next if shelters[shelter[:id][:$t]]
#       shelters[shelter[:id][:$t]] = Hash[shelter.map { |k, v| [k, v[:$t]] }]
#     end
#     puts shelters.count
#   end
#   puts "#{state}: #{shelters.count}"
#
# puts shelters.count
# puts shelters.map { |_k, sh| sh[:state] }.uniq
# puts shelters.map { |k, _v| k }
#

end
