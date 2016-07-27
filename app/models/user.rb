class User < ActiveRecord::Base
  has_many :faves
  has_many :pets, through: :faves
  has_many :faved_pets, through: :faves, source: :pets

  has_attached_file :photo, styles: { small: "150x150>" }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_attachment_content_type :photo, content_type: /\Aimage/
  validates_attachment_size :photo, less_than: 3.megabytes
  validates :name, presence: true
end
