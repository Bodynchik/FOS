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
    title_manufacturer.to_s
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[chats messages products]
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at email encrypted_password id id_value person_last_name person_middle_name person_name phone_number remember_created_at
       reset_password_sent_at reset_password_token title_manufacturer updated_at]
  end
end
