class UserMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.create_notification.subject

  def sender(user)
    @user = user
    mail(to: @user.email, subject: 'Test Email for Letter Opener')
  end

  def create_notification
    @greeting = 'Hi'

    mail to: 'to@example.org'
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.update_notification.subject
  #
  def update_notification
    @greeting = 'Hi'

    mail to: 'to@example.org'
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.delete_notification.subject
  #
  def delete_notification
    @greeting = 'Hi'

    mail to: 'to@example.org'
  end
end
