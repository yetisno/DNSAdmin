class AdminDomainsController < ApplicationController
	include Loginable
	before_action :check_admin

	def index
		@domains = Domain.all
	end

	def check_admin
		redirect_to root unless current_user.admin
	end
end
