class UsersController < ApplicationController
  before_action :set_favorite_categories, only: %i[index add_favorite_category remove_favorite_category]

  def index
    UserNotificationService.new(User.new(email: 'soroka2021ks12@student.karazin.ua')).send_create_notification
    @users = User.all
  end

  def add_favorite_category
    category_name = params[:category_name]
    current_user.favorite_categories << category_name unless @favorite_categories.include?(category_name)
    return unless current_user.save

    redirect_back(fallback_location: root_path)
  end

  def remove_favorite_category
    category_name = params[:category_name]
    current_user.favorite_categories.delete(category_name)
    return unless current_user.save

    redirect_back(fallback_location: root_path)
  end

  private

  def set_favorite_categories
    @favorite_categories = current_user.favorite_categories || []
  end
end
