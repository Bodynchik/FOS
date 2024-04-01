require 'nokogiri'
require 'open-uri'
require_relative '../../config/environment'
require_relative '../../app/models/furniture'

namespace :parse do
  desc "Парсимо сайт і зберігаємо назву продуктів"

  task :name => :environment do
    url = 'https://www.enchantedlearning.com/wordlist/furniture.shtml#wls-id-a'
    doc = Nokogiri::HTML(URI.open(url))

    begin
      doc.css('.wordlist-item').each do |word|
          name = word.text
          Furniture.create(name: name)
        end
    rescue StandardError => e
      puts "Помилка: #{e.message}"
    end
  end
end