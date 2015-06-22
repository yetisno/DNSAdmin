class ApiDomainController < ApiController

	def getDomain
		@domain_name = params[:domain_id]
		if admin?
			Domain.friendly.find(@domain_name)
		else
			current_user.domains.friendly.find(@domain_name)
		end
	end
end
