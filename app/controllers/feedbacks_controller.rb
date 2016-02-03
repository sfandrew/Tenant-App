class FeedbacksController < ApplicationController
  before_filter :authorized_personel, only: [:index, :new, :show, :update, :destroy]
  before_action :set_feedback, only: [:show, :edit, :update, :destroy]

  def index
    @feedbacks = Feedback.order(created_at: :desc).includes(:user).paginate(:page => params[:page], :per_page => 30)
  end

  def show
  end

  def new
    @feedback = Feedback.new
  end

  def edit
  end

  def create
    @feedback = Feedback.new(feedback_params)
    @feedback.user = current_user
    respond_to do |format|
      if @feedback.save
        format.js { render :js => "$('#feedbackModal').modal('hide');" }
      else
        format.js { render :js => "alert('You cannot submit an empty form!');" }
      end
    end
  end

  def update
    flash[:notice] = 'Feedback was successfully updated.' if @feedback.update(feedback_params)
  end

  def destroy
    @feedback.destroy
    redirect_to feedbacks_url, notice: 'Feedback was successfully destroyed.'
  end

  private
    def set_feedback
      @feedback = Feedback.find(params[:id])
    end

    def feedback_params
      params.require(:feedback).permit(:user_id, :report)
    end
end
