module Apiable
	extend ActiveSupport::Concern

	included do
		before_action :getDomain
	end

	def getDomain
		@domain_name = params[:domain_id]
		if admin?
			Domain.includes(:as).friendly.find(@domain_name)
		else
			@user.domains.includes(:as).friendly.find(@domain_name)
		end
	end
end
