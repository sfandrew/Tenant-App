class Attachment < ActiveRecord::Base
	belongs_to :user
	belongs_to :attachable, :polymorphic => true, :dependent => :destroy

	mount_uploader :filename, AttachmentUploader
	validates :filename, allow_blank: true, format:{
		with: %r{\.(gif|jpg|png)\Z}i,
		message: 'must be a URL for GIF, JPG or PNG image.'
	}
	# validates :content_meta, presence: :true

end
