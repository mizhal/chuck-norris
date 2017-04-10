class QueryMailer < ApplicationMailer
	default from: "mizhal@gmail.com"

	layout "mailer"

	def basic query 
		@query = query
		mail(to: query.send_to_mail, subject: I18n.t(:chuck_norris_quotes))
	end
end
