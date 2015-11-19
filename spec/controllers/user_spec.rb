require 'spec_helper'
require 'factory_girl_rails'

RSpec.describe UsersController, :type => :controller do
	before :each do
		@user = create(:user)
		sign_in @user
	end
	
	describe "GET #index" do
		it "renders the index template" do
			@user.role = 'admin'
			get :index
			expect(response.status).to eq(200)
		end
	end
end

