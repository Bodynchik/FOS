class UsersController < ApplicationController
  def index
    UserMailer.sender(User.new(email: 'soroka2021ks12@student.karazin.ua')).deliver
    @users = User.all
  end
end
