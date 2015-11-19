require 'spec_helper'
require 'factory_girl_rails'

RSpec.describe DynamicFormsEngine::DynamicFormTypesController, :type => :controller do 
	routes { DynamicFormsEngine::Engine.routes }

	# let(:user) { FactoryGirl.create(:user) }
 #  	let(:current_user) {user}

	before :each do 
		@user = create(:user)
		# attrs = attributes_for(:user)
		# attrs.role = 'admin'
    	sign_in @user
		
  	end
	

	describe "GET #index" do
		it "responds successfully with an HTTP 200 status code" do
			# sign_in
			get :index
			expect(response).to be_success
			expect(response).to have_http_status(200)
		end 
	end

end