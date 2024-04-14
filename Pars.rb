# rubocop:disable all
# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'
require 'csv'

def google_search(link)
  hash_map = {}
  begin
    doc = Nokogiri::HTML(URI.open(link))
    Rails.logger.debug { "Title: #{doc.title}" }
    doc.css('.wordlist-section').each do |block|
      heading = block.css('.wordlist-section__title').text
      Rails.logger.debug { "Letter: #{heading}" }
      words = block.css('.wordlist-item').map(&:text)
      Rails.logger.debug(words.join("\n"))
      hash_map[heading] = words
    end
  rescue StandardError => e
    Rails.logger.debug { "Error: #{e.message}" }
  end

  hash_map
end

def go_to_csv(hash_map)
  csv_file_path = File.join(__dir__, 'data.csv')
  CSV.open(csv_file_path, 'wb') { |csv| csv << %w[Heading Words] } unless File.exist?(csv_file_path)

  CSV.open(csv_file_path, 'w') do |csv|
    hash_map.each { |key, value| csv << [key, value.join(', ')] }
  end
end

hash_map = google_search('https://www.enchantedlearning.com/wordlist/furniture.shtml#wls-id-a')
go_to_csv(hash_map)
# rubocop:enable all