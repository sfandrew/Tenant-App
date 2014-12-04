class Contact < ActiveRecord::Base
	belongs_to :user
	has_many :contactables_join, source: :contactables
	has_many :contactables, :through => :contactables_join, :source => :contactables
	validates :contact_type, :first_name, :email, presence: :true
	validates :contact_type, inclusion: { in: ["Property Manager","Landlord","Guarantor","Resident Manager","Roommate","Family","Other"], 
											message: "%{value} is not a valid size" }
	before_create :set_uuid


	def set_user_id(i)
		self.user_id = i
		self.save
	end

	private

	def set_uuid
		self.uuid = SecureRandom.uuid
	end
end
