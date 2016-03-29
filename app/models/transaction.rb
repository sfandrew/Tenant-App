class Transaction < ActiveRecord::Base
	belongs_to :dynamic_form_entry, class_name: "DynamicFormsEngine::DynamicFormEntry"
	belongs_to :user

	def self.search(terms)
		query = Transaction.includes(:user, :dynamic_form_entry)

		unless terms[:email].blank?
			query = query.where(:users => {:email => terms[:email] })
		end

		unless terms[:braintree_id].blank?
			query = query.where(:braintree_id => terms[:braintree_id])
		end

		unless terms[:submitted].blank?
			date_submitted = Date.parse(terms[:submitted]).to_time
			query = query.where(:created_at => date_submitted.beginning_of_day..date_submitted.end_of_day)
		end

		return query

	end


end
