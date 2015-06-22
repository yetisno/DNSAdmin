class Api::CnamesController < ApiDomainController
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
		@cnames = @domain.cnames
	end

	def show
		@cname = getDomain.cnames.find @id
	end

	def create
		begin
			domain = getDomain
			cname = params.require(:cname).permit(:name, :to_name)
			cname[:name] = "#{cname[:name]}#{'.' unless cname[:name].blank?}#{domain.name}"
			domain.cnames.create! cname
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
			@cname = getDomain.cnames.find @id
			@cname.destroy!
			@success = true
		rescue
			@success = false
		end
		respond_to do |format|
			format.json { render status: @success ? :ok : :bad_request }
		end
	end
end
