# frozen_string_literal: true

module Users
  class ApplicationController < ApplicationController
    respond_to :json, :html
    before_action :configure_permitted_parameters, if: :devise_controller?
    skip_before_action :verify_authenticity_token, if: :devise_controller?

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: %i[name avatar])
      devise_parameter_sanitizer.permit(:account_update, keys: %i[name avatar])
    end
  end
end
