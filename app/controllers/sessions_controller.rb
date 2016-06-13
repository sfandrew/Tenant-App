class SessionsController < Devise::SessionsController

  before_filter :check_user_confirmation, only: :create

  def after_sign_in_path_for(resource)
  	if DynamicFormsEngine::DynamicFormEntry.redirect_to_user_draft_entry(current_user)
  		dynamic_forms_engine.edit_dynamic_form_entry_path(DynamicFormsEngine::DynamicFormEntry.redirect_to_user_draft_entry(current_user))
  	else
      stored_location_for(resource) || home_landing_page_path
	  end
  end


private

  def check_user_confirmation
    user = User.find_by_email(params[:user][:email])
    flash[:alert] = "You have to activate before logging in."
    redirect_to new_confirmation_path(:user) unless user && user.confirmed?
  end
end