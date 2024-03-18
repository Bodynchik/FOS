require 'nokogiri'
require 'open-uri'
require 'pg'

namespace :parse do
  desc "Парсимо сайт, зберігаємо назви продуктів у таблицю"

  task :prod_name do
    url = 'https://www.enchantedlearning.com/wordlist/furniture.shtml#wls-id-a'

    doc = Nokogiri::HTML(URI.open(url))

    conn = PG.connect(dbname: 'myapp_development', user: 'postgres', password: 'root')

    begin
      result = conn.exec_params('INSERT INTO categories (cat_name) VALUES ($1) RETURNING id', ['kitchen'])
      category_id = result[0]['id'].to_i if result.num_tuples > 0

      result = conn.exec_params('INSERT INTO manufactures (manufacture_country) VALUES ($1) RETURNING id', ['Ukrain'])
      manufacture_id = result[0]['id'].to_i if result.num_tuples > 0

      doc.css('.wordlist-section').each do |block|
        sub_category_name = block.css('.wordlist-section__title').text

        result = conn.exec_params('INSERT INTO sub_categories (category_id, subcat_name) VALUES ($1, $2) RETURNING id', [category_id, sub_category_name])
        sub_category_id = result[0]['id'].to_i if result.num_tuples > 0

        block.css('.wordlist-item').each do |word|
          prod_name = word.text
          conn.exec_params('INSERT INTO products (sub_category_id, prod_name, manufacture_id) VALUES ($1, $2, $3)', [sub_category_id, prod_name, manufacture_id])
        end

      end

    rescue PG::Error => e
      puts "Помилка бази даних: #{e.message}"
    ensure
      conn.close if conn
    end

  end
end