class Users::ProfilesController < ApplicationController
  def show
    @orders = current_user.orders
    @prod_sets = current_user.prod_sets
    @user_chats = current_user # Для чатів

    service = PrivatbankService.new(nil, current_user)
    @exchange_rate = service.user_to_usd_exchange_rate

    @prod_set = ProdSet.new
  end
end
