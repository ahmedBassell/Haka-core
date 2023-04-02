module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :configure_permitted_parameters

    protected

    def configure_permitted_parameters
      # Add the extra attribute to the list of permitted parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:display_name, :phone])
    end

    def sign_up_params
      # Override the sign_up_params method to include the extra attribute
      params.require(:user).permit(:email, :password, :password_confirmation, :display_name, :phone)
    end
  end
end