class RssFeedService
  require 'builder'
  include Rails.application.routes.url_helpers

  def initialize(products, context)
    @products = products
    @context = context
    @user = context.try(:current_user)
  end

  def call
    xml = Builder::XmlMarkup.new
    xml.instruct! :xml, version: '1.0'
    xml.rss version: '2.0' do
      xml.channel do
        xml.title 'Нові товари'
        xml.description 'Перелік доданих нових товарів від різних виробників'

        @products.each do |product|
          xml.item do
            xml.title product.prod_model
            xml.description(type: 'html') do
              xml.cdata!(product_description(product))
            end
            xml.link product_url(product)
            xml.pubDate product.created_at.rfc2822
          end
        end
      end
    end
    xml.target!
  end

  private

  def product_description(product)
    "
      <div style='display: flex; justify-content: center;'>
        <div style='width: 250px; height: auto;'>
          <img src='#{url_for(product.product_image) if product.product_image.attached?}'>
        </div>
        <div style='max-width: 400px; margin-left: 40px;'>
          <h1 style='margin: 0 0 18px;'>#{product.prod_model}</h1>
          <p style='color: #4d4d4d; font-weight: bold; font-size: 20px; margin: 0;'>#{product_price(product)}</p>
          <h2 style='margin: 18px 0 15px;'>Опис</h2>
          <p style='margin: 0; max-width: 400px; word-wrap: break-word;'>#{product.description}</p>
        </div>
      </div>
    "
  end

  def product_url(product)
    @context.product_url(product)
  end

  def product_price(product)
    return "#{product.price} UAH" unless @user
    return "#{product.price} #{@user.currency}" if @user

    service = PrivatbankService.new(product, @user)
    service.convert_price_to_user_currency
    "#{product.price} #{@user.currency}"
  end

  def url_for(image)
    @context.rails_blob_url(image)
  end
end
