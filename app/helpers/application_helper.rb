module ApplicationHelper

	def attachment_preview(attachment)
		if attachment.object.filename.content_type == 'application/pdf'
			link_to("Download #{File.basename(attachment.object.filename.path)}", attachment.object.filename.url, class: 'btn btn-success')
		else
			link_to(image_tag(attachment.object.filename_url_or_cached_url,size: "100" ), attachment.object.filename.url, :target => "_blank")
		end
	end
	
end
