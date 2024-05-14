# app/services/user_notification_service.rb
class UserNotificationService
  def initialize(user)
    @user = user
  end

  def send_create_notification
    UserMailer.create_notification(@user).deliver_now
  end

  def send_update_notification
    UserMailer.update_notification(@user).deliver_now
  end

  def send_delete_notification
    UserMailer.delete_notification(@user).deliver_now
  end
end
