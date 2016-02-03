module UsersHelper


	def user_role_select
		if current_user.admin?
			[['Admin','admin'],['Normal User','user']]
		else
			[['Admin','admin'],['Normal User','user'], ['Super User', 'super-user']]
		end
	end
end
