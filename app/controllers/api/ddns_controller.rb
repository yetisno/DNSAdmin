class Api::DdnsController < ApiDomainController
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
		@ddns = @domain.ddns
	end

	def show
		@ddn = getDomain.ddns.find_by_token @id
	end

	def create
		begin
			domain = getDomain
			data = params.require(:ddn).permit(:name, :to_ip, :device_name)
			data[:token] = SecureRandom.uuid
			data[:name] = "#{data[:name]}#{'.' unless data[:name].blank?}#{domain.name}"
			ddn = domain.ddns.create! data.permit(:token, :device_name)
			data[:domain_id] = ddn.domain_id
			data[:ddn_id] = ddn.id
			ddn.a = A.create! data.permit(:domain_id, :ddn_id, :name, :to_ip)
			@success = true
		rescue
			@success = false
		end
		respond_to do |format|
			format.json { render status: @success ? :created : :bad_request }
		end
	end

	def update
		begin
			data = params.require(:ddn).permit(:to_ip)
			if data[:to_ip] == ''
				data[:to_ip] = request.remote_ip
			end
			ddn = Ddn.find_by_token @id
			ddn.a.update! data.permit(:to_ip)
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
			@ddn = Ddn.find_by_token @id
			@ddn.destroy!
			@success = true
		rescue
			@success = false
		end
		respond_to do |format|
			format.json { render status: @success ? :ok : :bad_request }
		end
	end
end
