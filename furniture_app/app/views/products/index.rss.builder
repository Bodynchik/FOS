xml.instruct! :xml, version: '1.0'
xml.rss version: '2.0' do
  xml.channel do
    xml.title "Нові товари"
    xml.description "Перелік доданих нових товарів від різних виробників"

    @products.each do |product|
      xml.item do
        xml.title product.prod_model
        xml.description(type: 'html') do
          xml.cdata!("<p><span style='font-weight: bold;'>Ціна</span>: ₴#{product.price}</p>
                          <p><span style='font-weight: bold;'>Опис</span>: #{product.description}</p>")
        end
        xml.link product_url(product)
        xml.pubDate product.created_at.rfc2822
      end
    end
  end
end