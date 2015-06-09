class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
         
  has_many :dynamic_form_entries, class_name: "DynamicFormsEngine::DynamicFormEntry"
  has_many :contacts


	def contact_ids
		Contact.where(email: self.email).pluck(:id)
	end
end
