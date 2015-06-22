class Api::MembersController < ApiDomainController
	include Loginable
	before_action do
		@user = current_user
		@id = params[:id] unless params[:id].blank?
	end
	after_action do
		DNServiceOperation.reload if @success
	end

	def index
		@domain = getDomain
		@members = @domain.users
	end

	def show
		@member = getDomain.users.friendly.find @id
	end

	def create
		begin
			getDomain.user_domain_maps.create!({user_id: User.friendly.find(params.require(:member)[:username]).id})
			@success = true
		rescue
			@success = false
		end
		respond_to do |format|
			format.json { render status: @success ? :created : :bad_request }
		end
	end

	def destroy
		begin
			@domain = getDomain
			@relation = @domain.user_domain_maps.find_by user_id: (@domain.users.friendly.find(params[:id]).id)
			@relation.destroy!
			@success = true
		rescue
			@success = false
		end
		respond_to do |format|
			format.json { render status: @success ? :ok : :bad_request }
		end
	end
end
