class Users::ProfilesController < ApplicationController
  def show
    @orders = current_user.orders
    @prod_sets = current_user.prod_sets
    @user_chats = current_user # Для чатів

    @exchange_rate = current_user.get_exchange_rates(current_user.currency)
  end
end
