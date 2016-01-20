class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  validates :role, inclusion: %w(user admin), on: :update, :if => :role_changed?
  
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable, :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]
         
  has_many :dynamic_form_entries, class_name: "DynamicFormsEngine::DynamicFormEntry"
  has_many :dynamic_form_types, class_name: "DynamicFormsEngine::DynamicFormType"
  has_many :feedbacks
  has_many :contacts

  before_create :set_role

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name || ''
      user.uid = auth.uid
      user.provider = auth.provider
      user.skip_confirmation!
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def admin?
    role == 'admin'
  end

  def omniauth_user?
    !provider.blank?
  end


	def contact_ids
		Contact.where(email: self.email).pluck(:id)
	end

  private

    def set_role
      self.role = 'user'
    end
end
