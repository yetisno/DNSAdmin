class Api::NameserversController < ApiDomainController
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
		@nameservers = @domain.nameservers
	end

	def show
		@nameserver = getDomain.nameservers.find @id
	end

	def create
		begin
			domain = getDomain
			nameserver = params.require(:nameserver).permit(:name, :to_ns)
			nameserver[:name] = "#{nameserver[:name]}#{'.' unless nameserver[:name].blank?}#{domain.name}"
			nameserver[:to_ns] = "#{nameserver[:to_ns]}"
			domain.nameservers.create! nameserver
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
			@nameserver = getDomain.nameservers.find @id
			@nameserver.destroy!
			@success = true
		rescue
			@success = false
		end
		respond_to do |format|
			format.json { render status: @success ? :ok : :bad_request }
		end
	end
end
