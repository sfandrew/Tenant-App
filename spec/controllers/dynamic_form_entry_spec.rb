require 'spec_helper'
require 'factory_girl_rails'

RSpec.describe DynamicFormsEngine::DynamicFormTypesController, :type => :controller do 
	routes { DynamicFormsEngine::Engine.routes }

	before :each do 
		@user = create(:user)
    	sign_in @user
  	end
	

	describe "GET #index" do
		it "responds successfully with an HTTP 200 status code" do
			get :index
			expect(response).to be_success
			expect(response).to have_http_status(200)
		end 
	end

end