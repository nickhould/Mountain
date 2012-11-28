module PagesHelper


	def percentage_from_total(page, total)
		percentage = ( page.to_f / total.to_f ) * 100
		percentage = percentage.round(2)
	end
end
