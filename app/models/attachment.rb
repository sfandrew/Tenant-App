class Attachment < ActiveRecord::Base
	belongs_to :user
	belongs_to :attachable, :polymorphic => true, :dependent => :destroy
	# attr_accessor :filename_cache

	mount_uploader :filename, AttachmentUploader
	validates :filename, allow_blank: true, format:{
		with: %r{\.(gif|jpg|png)\Z}i,
		message: 'must be a URL for GIF, JPG or PNG image.'
	}
	# validates :content_meta, presence: :true

	def filename_url_or_cached_url
		filename_url || filename_cache
	end

end
