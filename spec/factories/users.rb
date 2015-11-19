require 'faker'

FactoryGirl.define do
	factory :user do |f|
		f.name {Faker::Name.first_name}
		f.email {Faker::Internet.email}
		f.role 'admin'

		p = Faker::Internet.password

		f.password p
		f.confirmed_at Date.today



	end		
end
