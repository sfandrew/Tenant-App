module ApplicationHelper

	def attachment_preview(attachment)
		download_attachment_types = ['application/pdf', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet']
		picture_attachment_types = ['image/jpeg', 'image/png', 'image/jpg']

		if download_attachment_types.include?(attachment.object.filename.content_type)
			link_to("Download #{File.basename(attachment.object.filename.path)}", attachment.object.filename.url, class: 'btn btn-success')
		elsif picture_attachment_types.include?(attachment.object.filename.content_type)
			link_to(image_tag(attachment.object.filename_url_or_cached_url,size: "100" ), attachment.object.filename.url, :target => "_blank")
		
		end
	end

	def sortable(column, title = nil)
		title ||= column.titleize
    	direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
    	link_to title, :sort => column, :direction => direction
	end
	
end
