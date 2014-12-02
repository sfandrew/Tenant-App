class Contactable < ActiveRecord::Base
	belongs_to :contact
	belongs_to :contactable, :polymorphic => true
end
