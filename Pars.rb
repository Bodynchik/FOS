# frozen_string_literal: true
require 'nokogiri'
require 'open-uri'
require 'csv'

def google_search(link)
  hash_map = {}
  begin
    doc = Nokogiri::HTML(URI.open(link))
    puts "Title: #{doc.title}"
    doc.css(".wordlist-section").each do |block|
      heading = block.css(".wordlist-section__title").text
      puts "Letter: " + heading
      words = []
      block.css(".wordlist-item").each do |word|
        words << word.text
        puts "   " + word.text
      end
      hash_map[heading] = words
    end

    csv_file_path = "data.csv"
    unless File.exist?(csv_file_path)
      CSV.open(csv_file_path, 'wb') do |csv|
        csv << ["Heading", "Words"]
      end
    end


    CSV.open(csv_file_path, 'w') do |csv|
      hash_map.each do |key, value|
        csv << [key, value.join(", ")]
      end
    end

  rescue StandardError => e
    puts "Error: #{e.message}"
  end
end

google_search("https://www.enchantedlearning.com/wordlist/furniture.shtml#wls-id-a")
