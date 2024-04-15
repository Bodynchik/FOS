class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :manufacturer

  has_many :messages
end
