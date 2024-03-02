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

  rescue StandardError => e
    puts "Error: #{e.message}"
  end

  return hash_map
end

def go_to_csv(hash_map)
  current_directory = __dir__
  csv_file_path = File.join(current_directory, "data.csv")
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

end


hashh = google_search("https://www.enchantedlearning.com/wordlist/furniture.shtml#wls-id-a")
go_to_csv(hashh)