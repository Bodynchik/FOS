require 'nokogiri'
require 'open-uri'
require_relative '../../config/environment'
require_relative '../../app/models/furniture'
require_relative '../../app/models/category'
require_relative '../../app/models/sub_category'

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

  task :categories => :environment do
    Category.create([
                      { cat_name: 'Вітальня' },
                      { cat_name: 'Кухня' },
                      { cat_name: 'Спальня' },
                      { cat_name: 'Робоча зона' },
                      { cat_name: 'Зберігання' },
                      { cat_name: 'Сад' }
                    ])
    puts "Категорії вставлено успішно!"
  end

  task :sub_categories => :environment do
    categories = Category.all
    sub_categories_data = [
      { category_id: categories.find_by(cat_name: 'Вітальня').id, subcat_name: 'Крісла' },
      { category_id: categories.find_by(cat_name: 'Вітальня').id, subcat_name: 'Пуфи' },
      { category_id: categories.find_by(cat_name: 'Вітальня').id, subcat_name: 'Дивани' },
      { category_id: categories.find_by(cat_name: 'Вітальня').id, subcat_name: 'Дивани-ліжка' },
      { category_id: categories.find_by(cat_name: 'Вітальня').id, subcat_name: 'Столики' },
      { category_id: categories.find_by(cat_name: 'Вітальня').id, subcat_name: 'Тумби під телевізор' },
      { category_id: categories.find_by(cat_name: 'Кухня').id, subcat_name: 'Барні стільці' },
      { category_id: categories.find_by(cat_name: 'Кухня').id, subcat_name: 'Барні столи' },
      { category_id: categories.find_by(cat_name: 'Кухня').id, subcat_name: 'Обідні столи' },
      { category_id: categories.find_by(cat_name: 'Кухня').id, subcat_name: 'Обідні стільці' },
      { category_id: categories.find_by(cat_name: 'Кухня').id, subcat_name: 'Складні стільці' },
      { category_id: categories.find_by(cat_name: 'Спальня').id, subcat_name: 'Дзеркала' },
      { category_id: categories.find_by(cat_name: 'Спальня').id, subcat_name: 'Дитячі ліжка' },
      { category_id: categories.find_by(cat_name: 'Спальня').id, subcat_name: 'Ліжка' },
      { category_id: categories.find_by(cat_name: 'Робоча зона').id, subcat_name: 'Крісла офісні' },
      { category_id: categories.find_by(cat_name: 'Робоча зона').id, subcat_name: 'Стіл комп`ютерний' },
      { category_id: categories.find_by(cat_name: 'Робоча зона').id, subcat_name: 'Столи з регулюванням висоти' },
      { category_id: categories.find_by(cat_name: 'Зберігання').id, subcat_name: 'Вуличне зберігання' },
      { category_id: categories.find_by(cat_name: 'Зберігання').id, subcat_name: 'Буфети та серванти' },
      { category_id: categories.find_by(cat_name: 'Зберігання').id, subcat_name: 'Книжкові шафи' },
      { category_id: categories.find_by(cat_name: 'Зберігання').id, subcat_name: 'Комоди' },
      { category_id: categories.find_by(cat_name: 'Зберігання').id, subcat_name: 'Консольні столики' },
      { category_id: categories.find_by(cat_name: 'Зберігання').id, subcat_name: 'Передпокій' },
      { category_id: categories.find_by(cat_name: 'Зберігання').id, subcat_name: 'Пересувні вішалки' },
      { category_id: categories.find_by(cat_name: 'Зберігання').id, subcat_name: 'Полиці' },
      { category_id: categories.find_by(cat_name: 'Зберігання').id, subcat_name: 'Шафи' },
      { category_id: categories.find_by(cat_name: 'Зберігання').id, subcat_name: 'Приліжкові тумби' },
      { category_id: categories.find_by(cat_name: 'Сад').id, subcat_name: 'Гамаки' },
      { category_id: categories.find_by(cat_name: 'Сад').id, subcat_name: 'Вуличне освітлення' },
      { category_id: categories.find_by(cat_name: 'Сад').id, subcat_name: 'Меблі для відпочинку' },
      { category_id: categories.find_by(cat_name: 'Сад').id, subcat_name: 'Садові стільці' },
      { category_id: categories.find_by(cat_name: 'Сад').id, subcat_name: 'Садові лави' },
      { category_id: categories.find_by(cat_name: 'Сад').id, subcat_name: 'Садові столи' },
      { category_id: categories.find_by(cat_name: 'Сад').id, subcat_name: 'Шезлонги' }
    ]
    SubCategory.create(sub_categories_data)
    puts "Підкатегорії вставлено успішно!"
  end
end