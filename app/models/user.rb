class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  validates :role, inclusion: %w(user admin), on: :update, :if => :role_changed?
  
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
         
  has_many :dynamic_form_entries, class_name: "DynamicFormsEngine::DynamicFormEntry"
  has_many :dynamic_form_types, class_name: "DynamicFormsEngine::DynamicFormType"


  has_many :contacts

  before_create :set_role

  def admin?
    role == 'admin'
  end


	def contact_ids
		Contact.where(email: self.email).pluck(:id)
	end

  private

    def set_role
      self.role = 'user'
    end
end
