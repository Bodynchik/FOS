require 'net/http'
require 'json'

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone_number, presence: true

  has_many :orders
  has_many :prod_sets
  has_many :chats
  has_many :comments, dependent: :destroy
  has_many :messages, dependent: :destroy

  def username
    "#{first_name} #{last_name}"
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[chats messages orders prod_sets]
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[confirmation_sent_at confirmation_token confirmed_at created_at email encrypted_password first_name id id_value last_name middle_name
       phone_number remember_created_at reset_password_sent_at reset_password_token unconfirmed_email updated_at]
  end
end
