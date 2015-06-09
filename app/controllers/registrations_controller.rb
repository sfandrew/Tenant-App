class RegistrationsController < Devise::RegistrationsController

	def create
	    build_resource(sign_up_params)
	    resource.save
	    yield resource if block_given?
	    if resource.persisted?
	      if resource.active_for_authentication?
	        set_flash_message :notice, :signed_up if is_flashing_format?
	        sign_up(resource_name, resource)
	        after_sign_up_path_for(resource)
	      else
	        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
	        expire_data_after_sign_in!
	        respond_with resource, location: after_inactive_sign_up_path_for(resource)
	      end
	    else
	      clean_up_passwords resource
	      respond_with resource
	    end
  	end


private
	def after_sign_up_path_for(resource)  
    	sign_out :user  
    	flash[:notice] = "You have to activate before logging in. Check your email for activating your account."  
    	redirect_to root_path
  	end

end
