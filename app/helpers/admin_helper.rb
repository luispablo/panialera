module AdminHelper
	
	def vert(text)
		text.split("").join("<br/>").html_safe
	end

end
