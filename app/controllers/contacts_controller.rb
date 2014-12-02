class ContactsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_contact, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @contacts = current_user.contacts
    respond_with(@contacts)
  end

  def show
    respond_with(@contact)
  end

  def new
    @contact = Contact.new
    respond_with(@contact)
  end

  def edit
  end

  def create
    @contact = current_user.contacts.new(contact_params)
    flash[:notice] = 'Contact was successfully created.' if @contact.save
    respond_with(@contact)
  end

  def update
    flash[:notice] = 'Contact was successfully updated.' if @contact.update(contact_params)
    respond_with(@contact)
  end

  def destroy
    @contact.destroy
    respond_with(@contact)
  end

  private
    def set_contact
      @contact = Contact.find(params[:id])
    end

    def contact_params
      params.require(:contact).permit(:user_id, :contact_type, :contactable_type, :first_name,:last_name,:address1,:address2,:city,:state,:zip,:company, :email, :phone, :uuid)
    end
end
