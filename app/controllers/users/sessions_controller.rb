class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  def new
    super
  end

  def create
    super
  end

  def destroy
    super
  end

  protected
    def after_sign_out_path_for(resource)
      top_contributions_path
    end
  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
