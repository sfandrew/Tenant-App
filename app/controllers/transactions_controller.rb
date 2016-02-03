class TransactionsController < ApplicationController
	before_filter :generate_client_token, only: [:new]
	before_filter :get_entry, only: [:new, :create]
	before_action :authorized_personel, only: [:index]

	def index
		@transactions = Transaction.order(created_at: :desc).paginate(:page => params[:page], :per_page => 30)
	end

	def new
		redirect_to dynamic_forms_engine.dynamic_form_entries_path, alert: 'This application has already been paid' if @entry.payment
	end

	def create
		nonce = params[:payment_method_nonce]
		result = Braintree::Transaction.sale(
			:amount => 30.00,
			:payment_method_nonce => nonce
			)

		if result.success?
			Transaction.create(:dynamic_form_entry_id => @entry.id, :braintree_id => result.transaction.id, :payment_type => result.transaction.payment_instrument_type)
			@entry.update_columns(app_fee_paid: true)
			flash[:notice] = 'Application payment successful!'
			redirect_to dynamic_forms_engine.dynamic_form_entries_path
		else
			flash[:alert] = 'Payment unsuccessful, please try again'
			render :new
		end
	end

	private

	def transaction_params
      params.require(:transaction).permit(:dynamic_form_entry_id, :braintree_id, :payment_type, :amount)
    end

    def get_entry
    	@entry = DynamicFormsEngine::DynamicFormEntry.find(params[:id])
    end

	def generate_client_token
		@client_token = Braintree::ClientToken.generate
	end

end
