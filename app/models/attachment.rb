class Attachment < ActiveRecord::Base
	belongs_to :user
	belongs_to :attachable, :polymorphic => true, :dependent => :destroy
	# attr_accessor :filename_cache

	mount_uploader :filename, AttachmentUploader
	validates :filename, allow_blank: true, format:{
		with: %r{\.(gif|jpg|jpeg|png|pdf|xlsx|docx)\Z}i,
		message: 'must be a URL for GIF, JPG, PDF, DOCX or PNG image.'
	}

	def filename_url_or_cached_url
		filename_url || filename_cache
	end

end
