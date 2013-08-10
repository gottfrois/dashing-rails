module Dashing
  class ApplicationController < ActionController::Base

    private

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
