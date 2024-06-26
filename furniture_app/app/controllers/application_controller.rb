class ApplicationController < ActionController::Base
  around_action :switch_locale

  private

  def switch_locale(&)
    locale = locale_from_url || I18n.default_locale
    I18n.with_locale(locale, &)
  end

  def locale_from_url
    locale = params[:locale]

    locale if I18n.available_locales.map(&:to_s).include?(locale)
  end

  def default_url_options
    { locale: I18n.locale }
  end
end
