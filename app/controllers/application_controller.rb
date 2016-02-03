class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  before_filter :feedback_modal, :authenticate_user!

  def is_admin?
  	redirect_to root_path, alert: 'Only Admin can view the requested page' unless current_user.admin?
  end

  def is_superuser?
    redirect_to main_app.root_path, alert: 'Only Super Users can view the requested page' unless current_user.superuser?
  end

  def authorized_personel
    redirect_to root_path, alert: 'Only Authorized Personel can view the requested' unless current_user.authorized_users?
  end

  def is_omniauth_user?
    redirect_to root_path, alert: 'Cannot Edit Oauth Users' if current_user.omniauth_user?
  end

  def feedback_modal
  	@feedback = Feedback.new
  end


end
