class Pet < ActiveRecord::Base

  ANIMAL_TYPES = %w(barnyard bird cat dog horse pig reptile smallfurry)
  AGES = %w(baby young adult senior)
  SEXES = %w(male female)
  SIZES = %w(small medium large)

  belongs_to :shelter
  has_many :faves, destroy: true 

  validates :animal_type, :breed, :age, :sex, :name, :location, :description, :shelter_id, presence: true

  enum sex: SEXES
  enum age: AGES
  enum animal_type: ANIMAL_TYPES
  enum size: SIZES


  include HTTParty
  format :json
  base_uri 'api.petfinder.com'

  def self.find_by_breed(breed)
    get('/breed.list', :query => { key: "95c16e6439121fe454652ef459cb057e", animal: breed, format: 'json' })
  end

  def self.find_by_single_pet(single_pet)
    get('/pet.get', :query => { key: "95c16e6439121fe454652ef459cb057e", :id => single_pet, :format => 'json' })
  end

  def self.find_by_random(options)
    get('/pet.getRandom', :query => { key: "95c16e6439121fe454652ef459cb057e", :animal => options, breed: options, size: options, sex: options, location: options, shelterid: options, :format => 'json' })
  end

  def self.find_by_criteria(pet_criteria)
    get('/pet.find', :query => { key: "95c16e6439121fe454652ef459cb057e", :animal => pet_criteria, :breed => pet_criteria, :size => pet_criteria, :location => pet_criteria, :age => pet_criteria, :format => 'json' })
  end

  def self.find_by_shelter(shelter)
    get('/shelter.find', :query => { key: "95c16e6439121fe454652ef459cb057e", :location => shelter, :name => shelter, :format => 'json' })
  end

  def self.find_by_single_shelter(single_shelter)
    get('/shelter.get', :query => { key: "95c16e6439121fe454652ef459cb057e", :id => single_shelter, :format => 'json' })
  end

  def self.find_by_pet_records_for_shelter(pet_ids)
    get('/shelter.getPets', :query => {key: "95c16e6439121fe454652ef459cb057e", :id => pet_ids, :format => 'json' })
  end

  def self.find_by_shelter_list_breed(shelter_ids)
    get('/shelter.listByBreed', :query => { key: "95c16e6439121fe454652ef459cb057e", :animal => shelter_ids, :breed => shelter_ids, :format => 'json' })
  end

  def self.
end
