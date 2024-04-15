class Manufacturer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :person_name, presence: true
  validates :person_last_name, presence: true
  validates :title_manufacturer, presence: true
  validates :phone_number, presence: true

  has_many :products
  has_many :chats
  has_many :messages

  def username
    "#{title_manufacturer}"
  end
end
