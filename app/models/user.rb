class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  validates :role, inclusion: %w(user admin super-user), on: :update, :if => :role_changed?
  
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable, :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]
         
  has_many :dynamic_form_entries, class_name: "DynamicFormsEngine::DynamicFormEntry"
  has_many :dynamic_form_types, class_name: "DynamicFormsEngine::DynamicFormType"
  has_many :feedbacks
  has_many :contacts
  has_many :transactions

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

  def superuser?
    role == 'super-user'
  end

  def authorized_users?
    admin? || superuser?
  end

  def omniauth_user?
    !provider.blank?
  end

  def validate_user_role
    raise
    if current_user.admin? && superuser?
      errors.add(:base, 'Admin users cannot edit Super Users')
      return false
    end
  end


	def contact_ids
		Contact.where(email: self.email).pluck(:id)
	end

  def self.search(terms)
    search_query = User.includes(:dynamic_form_entries)

    if(!terms[:terms].blank?)
      search_query = User.includes(:dynamic_form_entries).order("#{terms[:order_by]} #{terms[:order]}")
    end

    if !terms[:start].blank? && !terms[:end].blank?
      date_start = Date.strptime(terms[:start], '%m/%d/%Y')
      date_end = Date.strptime(terms[:end], '%m/%d/%Y')
          
      search_query = search_query.where("created_at" => date_start..date_end)
    end

    if !terms[:email].blank?
      search_query = search_query.where("email like ?", "%#{terms[:email]}%")
    end

    return search_query
  end

  private

    def set_role
      self.role = 'user'
    end

    
end
