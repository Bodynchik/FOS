# app/controllers/users_controller.rb
class UsersController < ApplicationController
  def index
    UserNotificationService.new(User.new(email: 'soroka2021ks12@student.karazin.ua')).send_create_notification
    @users = User.all
  end
end
