class HomeController < ApplicationController
	skip_before_filter :authenticate_user!

	def home_page
	end
end
