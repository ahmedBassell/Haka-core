module Devise
  class CustomFailureApp < ::Devise::FailureApp
    def respond
      if request.content_type.include?('application/json')
        json_failure_response
      else
        super
      end
    end

    def json_failure_response
      self.status = 401
      self.content_type = 'application/json'
      self.response_body = { error: 'Authentication failed' }.to_json
    end
  end
end