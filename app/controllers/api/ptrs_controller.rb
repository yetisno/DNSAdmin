class Api::PtrsController < ApplicationController
	include Loginable
	before_action do
		@user = current_user
		@id = params[:id] unless params[:id].blank?
	end

	def index
		@ptrs = Ptr.all
	end
end
