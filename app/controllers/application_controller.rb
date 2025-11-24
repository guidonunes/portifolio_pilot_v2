class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:set_locale]
  before_action :configure_permitted_parameters, if: :devise_controller?
  around_action :switch_locale

  include Pundit::Authorization

  # Pundit: allow-list approach
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  # Uncomment when you *really understand* Pundit!
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(root_path)
  end

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name last_name])
  end

  def set_locale
    locale = params[:locale]
    if I18n.available_locales.map(&:to_s).include?(locale)
      session[:locale] = locale
      I18n.locale = locale
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/ || action_name == 'set_locale'
  end

  def switch_locale(&action)
    # Check session first, then params, then default
    locale = session[:locale] if session[:locale].present? && I18n.available_locales.map(&:to_s).include?(session[:locale].to_s)
    locale ||= params[:locale] if params[:locale].present? && I18n.available_locales.map(&:to_s).include?(params[:locale])
    locale ||= I18n.default_locale

    I18n.with_locale(locale, &action)
  end
end
