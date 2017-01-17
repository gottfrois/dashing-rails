module Dashing
  class ApplicationController < ActionController::Base

    before_action :authentication_with_devise

    private

    def authentication_with_devise
      Dashing.config.devise_allowed_models.each do |model|
        send("authenticate_#{model.to_s}!")
      end
    end

    def check_accessibility
      auth_token = params.delete(:auth_token)
      if !Dashing.config.auth_token || auth_token == Dashing.config.auth_token
        true
      else
        render nothing: true, status: 401 and return
      end
    end
  end
end
