class ContactablesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_contactable, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @contactables = Contactable.all
    respond_with(@contactables)
  end

  def show
    respond_with(@contactable)
  end

  def new
    @contactable = Contactable.new
    respond_with(@contactable)
  end

  def edit
  end

  def create
    @contactable = Contactable.new(contactable_params)
    flash[:notice] = 'Contactable was successfully created.' if @contactable.save
    respond_with(@contactable)
  end

  def update
    flash[:notice] = 'Contactable was successfully updated.' if @contactable.update(contactable_params)
    respond_with(@contactable)
  end

  def destroy
    @contactable.destroy
    respond_with(@contactable)
  end

  private
    def set_contactable
      @contactable = Contactable.find(params[:id])
    end

    def contactable_params
      params.require(:contactable).permit(:contact_id, :contactable_type, :contactable_id)
    end
end
