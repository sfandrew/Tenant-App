class SessionsController < Devise::SessionsController

  before_filter :check_user_confirmation, only: :create

  def after_sign_in_path_for(resource)
  	if DynamicFormsEngine::DynamicFormEntry.redirect_to_user_draft_entry(current_user)
  		dynamic_forms_engine.edit_dynamic_form_entry_path(DynamicFormsEngine::DynamicFormEntry.redirect_to_user_draft_entry(current_user))
  	else
	    sign_in_url = new_user_session_url
	    if request.referer == sign_in_url
	      super
	    else
	      stored_location_for(resource) || request.referer || root_path
	    end
	end
  end


private

  def check_user_confirmation
    user = User.find_by_email(params[:user][:email])
    flash[:alert] = "You have to activate before logging in."
    redirect_to new_confirmation_path(:user) unless user && user.confirmed?
  end
end