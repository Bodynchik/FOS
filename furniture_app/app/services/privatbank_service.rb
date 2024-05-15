require 'net/http'
require 'json'

class PrivatbankService
  def initialize(product, user)
    @product = product
    @user = user
  end

  def convert_order_price_to_user_currency(order)
    currency = @user.currency || 'UAH'
    exchange_rate = get_exchange_rate(currency)
    return unless exchange_rate

    order.total_price /= exchange_rate.to_f
    order.total_price = order.total_price.round(2)
  end

  def convert_price_to_user_currency
    currency = @user.currency || 'UAH'
    exchange_rate = get_exchange_rate(currency)
    return unless exchange_rate

    @product.price /= exchange_rate.to_f
    @product.price = @product.price.round(2)
  end

  def user_to_usd_exchange_rate
    currency = @user.currency || 'UAH'
    get_exchange_rate(currency, true)
  end

  private

  def get_exchange_rate(currency, for_profile = false)
    url = URI('https://api.privatbank.ua/p24api/pubinfo?exchange&coursid=11')
    response = Net::HTTP.get(url)
    data = JSON.parse(response)

    if for_profile
      usd_rate = 0.0
      eur_rate = 0.0
      result = 0.0

      data.each do |rate|
        if rate['ccy'] == 'USD'
          usd_rate = rate['buy'].to_f
        elsif rate['ccy'] == 'EUR'
          eur_rate = rate['buy'].to_f
        end
      end

      if currency == 'UAH'
        result = 1 / usd_rate
      elsif currency == 'EUR'
        result = eur_rate / usd_rate
      end

      result.round(2)
    else
      exchange_rate = nil
      data.each do |rate|
        if rate['ccy'] == currency
          exchange_rate = rate['buy']
          break
        end
      end

      exchange_rate
    end
  end
end
