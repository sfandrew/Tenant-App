class ConfirmationsController < Devise::ConfirmationsController



private


   def permitted_params
     params.require(resource_name).permit(:confirmation_token, :password, :password_confirmation)
   end
end