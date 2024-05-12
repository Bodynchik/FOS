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

  # Метод для отримання відношення валюти користувача до доллара
  def get_exchange_rates(currency)
    url = URI('https://api.privatbank.ua/p24api/pubinfo?exchange&coursid=11')
    response = Net::HTTP.get(url)
    data = JSON.parse(response)

    usd_rate = nil
    eur_rate = nil
    result = 0.0

    data.each do |rate|
      if rate['ccy'] == 'USD'
        usd_rate = rate['buy']
      elsif rate['ccy'] == 'EUR'
        eur_rate = rate['buy']
      end
    end

    if currency == 'UAH'
      result = 1 / usd_rate.to_f
    elsif currency == 'EUR'
      result = eur_rate.to_f / usd_rate
    end

    result.round(2)
  end
end
