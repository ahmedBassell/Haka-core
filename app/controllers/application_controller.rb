class ApplicationController < ActionController::API
  respond_to :json
  # include ActionController::MimeResponds
  before_action :authenticate_user!
  
  # Set url options for active storage service for generating attachment service url
  before_action do
    ::ActiveStorage::Current.url_options = { protocol: request.protocol, host: request.host, port: request.port }
  end
end
