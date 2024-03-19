require 'nokogiri'
require 'open-uri'
require_relative '../../config/environment'
require_relative '../../app/models/category'
require_relative '../../app/models/sub_category'
require_relative '../../app/models/product'
require_relative '../../app/models/manufacture'

namespace :parse do
  desc "Парсим сайт и сохраняем названия продуктов в таблицу"

  task :prod_name => :environment do
    url = 'https://www.enchantedlearning.com/wordlist/furniture.shtml#wls-id-a'
    doc = Nokogiri::HTML(URI.open(url))

    begin
      category = Category.create(cat_name: 'kitchen')
      manufacture = Manufacture.create(manufacture_country: 'Ukraine')

      doc.css('.wordlist-section').each do |block|
        sub_category_name = block.css('.wordlist-section__title').text
        sub_category = SubCategory.create(category_id: category.id, subcat_name: sub_category_name)

        block.css('.wordlist-item').each do |word|
          prod_name = word.text
          Product.create(sub_category_id: sub_category.id, prod_name: prod_name, manufacture_id: manufacture.id)
        end
      end
    rescue StandardError => e
      puts "Помилка: #{e.message}"
    end
  end
end