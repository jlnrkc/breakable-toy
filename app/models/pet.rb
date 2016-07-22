require 'rubygems'
require 'httparty'

class Pet < ActiveRecord::Base
  belongs_to :shelter
  has_many :faves

  validates :type, presence: true
  validates :breed, presence: true
  validates :age, presence: true
  validates :name, presence: true
  validates :description, presence: true
  validates :shelter_id, presence: true

  include HTTParty
  format :json
  base_url = 'api.petfinder.com'

  def self.find_by_breed(breed)
    get('/breed.list', :query => { :breed => breed, :output => 'json', key: "95c16e6439121fe454652ef459cb057e" })
  end

  def self.find_by_single_pet(single_pet)
    get('/pet.get', :query => { :single_pet => single_pet, :output => 'json', key: "95c16e6439121fe454652ef459cb057e" })
  end

  def self.find_by_random(random_pet)
    get('/pet.getRandom', :query => { :random_pet => random_pet, :output => 'json', key: "95c16e6439121fe454652ef459cb057e" })
  end

  def self.find_by_criteria(pet_criteriia)
    get('/pet.find', :query => { :pet_criteria => pet_criteria, :output => 'json', key: "95c16e6439121fe454652ef459cb057e" })
  end

  def self.find_by_shelter(shelter)
    get('/shelter.find', :query => { :shelter => shelter, :output => 'json', key: "95c16e6439121fe454652ef459cb057e" })
  end

  def self.find_by_single_shelter(single_shelter)
    get('/shelter.get', :query => { :single_shelter => single_shelter, :output => 'json', key: "95c16e6439121fe454652ef459cb057e" })
  end

  def self.find_by_pet_records_for_shelter(pet_ids)
    get('/shelter.getPets', :query => {:pet_ids => pet_ids, :output => 'json', key: "95c16e6439121fe454652ef459cb057e" })
  end

  def self.find_by_breed_shelter(shelter_ids)
    get('/shelter.listByBreed', :query => { :shelter_ids => shelter_ids, :output => 'json', key: "95c16e6439121fe454652ef459cb057e" })
  end
end
