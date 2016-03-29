class UsersController < ApplicationController
  helper_method :sort_column, :sort_direction

  before_action :authenticate_user!, :authorized_personel
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authorized_superusers, only: [:edit, :update]

  def index
    @users = User.order(last_sign_in_at: :desc).includes(:dynamic_form_entries).paginate(:page => params[:page], :per_page => 30)
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :role, :provider, :uid)
    end

    def sort_column
      User.column_names.include?(params[:sort]) ? params[:sort] : "email"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

    def authorized_superusers
      if current_user.admin?
        if params[:user]
          if user_params.has_value?('super-user')
            redirect_to users_path, alert: 'Only Super Users are allowed that action'
          end
        end
        redirect_to users_path, alert: 'Only Super Users can edit other Super Users' if @user.superuser?
      end
    end

end
