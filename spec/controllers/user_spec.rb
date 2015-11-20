require 'spec_helper'
require 'factory_girl_rails'

RSpec.describe UsersController, :type => :controller do

	before :each do
		@user = create(:user)
		sign_in @user
	end

	describe "When admin user signs in" do
		it "can access index page" do
			allow(controller).to receive(:is_admin?) { true }
			get :index
			expect(response.status).to eq(200)
		end
		it "can access new page" do
			allow(controller).to receive(:is_admin?) { true }
			get :new
			expect(response.status).to eq(200)
		end
		it "can edit a user" do
			allow(controller).to receive(:is_admin?) { true }
			user = FactoryGirl.create(:user)
			user.confirm
			get :edit, :id => user.id
			expect(response.status).to eq(200)
		end

	end

	describe "When a non-admin user signs in" do
		it "cannot access index page" do
			get :index
			expect(response.status).to eq(302)
		end
		it "cannot access new page" do
			get :new
			expect(response.status).to eq(302)
		end
		it "cannon edit a user" do
			user = FactoryGirl.create(:user)
			user.confirm
			get :edit, :id => user.id
			expect(response.status).to eq(302)
		end
	end

end

