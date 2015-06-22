class Api::SoaController < ApiDomainController
	include Loginable
	before_action do
		@user = current_user
		@id = params[:id] unless params[:id].blank?
	end
	after_action do
		DNServiceOperation.reload if @success
	end

	def show
		@domain = getDomain
		@soa = @domain.soa
	end

	def create
		begin
			getDomain.soa.create! params.require(:soa).permit(:name, :contact, :serial, :refresh, :retry, :expire, :minimum)
			@success = true
		rescue
			@success = false
		end
	end

	def update
		begin
			getDomain.soa.update! params.require(:soa).permit(:name, :contact, :serial, :refresh, :retry, :expire, :minimum)
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
			@soa = getDomain.soa
			@soa.destroy!
			@success = true
		rescue
			@success = false
		end
		respond_to do |format|
			format.json { render status: @success ? :ok : :bad_request }
		end
	end
end
