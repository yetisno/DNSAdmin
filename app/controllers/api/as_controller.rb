class Api::AsController < ApiDomainController
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
		@as = @domain.as
	end

	def show
		@a = getDomain.as.find @id
	end

	def create
		begin
			domain = getDomain
			a = params.require(:a).permit(:name, :to_ip)
			a[:name] = "#{a[:name]}#{'.' unless a[:name].blank?}#{domain.name}"
			domain.as.create! a
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
			@a = getDomain.as.find @id
			if @a.ddn_id.nil?
				@a.destroy!
				@success = true
			end
		rescue
			@success = false
		end
		respond_to do |format|
			format.json { render status: @success ? :ok : :bad_request }
		end
	end
end
