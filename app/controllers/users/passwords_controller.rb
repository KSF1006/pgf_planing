# app/controllers/users/passwords_controller.rb
module Users
  class Users::PasswordsController < Devise::PasswordsController
    # POST /resource/password
    def update
      self.resource = resource_class.reset_password_by_token(resource_params)
      yield resource if block_given?

      if resource.errors.empty?
        # If you want auto sign-in after reset, uncomment the next line:
        # sign_in(resource)

        flash[:notice] = "Your password has been changed successfully."
        redirect_to after_resetting_password_path_for(resource)
      else
        # Keep the Tailwind form styling by re-rendering edit with errors
        render :edit, status: :unprocessable_entity
      end
    end

    protected

    # Where to redirect users after password reset
    def after_resetting_password_path_for(resource)
      # Option 1: send to login page (default)
      new_session_path(resource_name)

      # Option 2 (uncomment if you want auto sign-in):
      # root_path
    end
  end
end