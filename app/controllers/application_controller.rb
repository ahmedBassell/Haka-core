class ApplicationController < ActionController::API
  respond_to :json
  include ActionController::MimeResponds
  before_action :authenticate_user!
end
