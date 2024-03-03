class Client < ApplicationRecord
  validates :client_name, :client_surname, :email, :password, :phone, presence: true
end
