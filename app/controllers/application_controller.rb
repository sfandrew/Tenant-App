class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  before_filter :feedback_modal, :authenticate_user!

  def is_admin?
  	redirect_to root_path, alert: 'Only Admin can view the requested page' unless current_user.role == 'admin'
  end

  def feedback_modal
  	@feedback = Feedback.new
  end




  
end
