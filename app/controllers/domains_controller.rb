class DomainsController < ApplicationController
	include Loginable
	before_action :set_domain, only: [:show, :edit, :update, :destroy]

	def index
		@domains = current_user.domains.all
	end

	def show
		@soa = @domain.soa
		@as = @domain.as
		@cnames = @domain.cnames
		@mxes = @domain.mxes
		@nameservers = @domain.nameservers
		@members = @domain.users
	end

	def new
		@domain = Domain.new
		@soa = Soa.new
	end

	def create
		respond_to do |format|
			begin
				ActiveRecord::Base.transaction do
					@domain = current_user.domains.create!(params.require(:domain).permit(:name, :description))
					@soa = params.require(:soa).permit(:contact, :refresh, :retry, :expire, :minimum)
					@soa[:contact] = @soa[:contact].gsub('@', '.')
					@soa[:domain_id] = @domain.id
					@soa[:name] = @domain.name
					@soa[:serial] = Time.now.to_i
					Soa.create!(@soa)
				end
				DNServiceOperation.reload
				format.html { redirect_to domains_path, notice: 'Domain was successfully created.' }
			rescue Exception => ex
				@domain = Domain.new params.require(:domain).permit(:name, :description)
				@soa = Soa.new @soa
				@soa[:contact].gsub('.', '@') unless @soa[:contact].blank?
				flash[:alert] = ex.message
				format.html { render :new }
			end
		end
	end

	def edit
		@soa = @domain.soa
		@soa.contact = @soa.contact.sub('.', '@')
	end

	def update
		respond_to do |format|
			begin
				ActiveRecord::Base.transaction do
					@domain.update!(params.require(:domain).permit(:description))
					@soa = params.require(:soa).permit(:contact, :refresh, :retry, :expire, :minimum)
					@soa[:contact] = @soa[:contact].gsub('@', '.')
					@soa[:serial] = Time.now.to_i
					@domain.soa.update!(@soa)
				end
				DNServiceOperation.reload
				format.html { redirect_to domains_path, notice: 'Domain was successfully updated.' }
			rescue Exception => ex
				@soa = Soa.new @soa
				@soa[:contact].gsub('.', '@') unless @soa[:contact].blank?
				flash[:alert] = ex.message
				format.html { render :edit }
			end
		end
	end

	def destroy
		begin
			@domain.destroy
			DNServiceOperation.reload
		rescue
		end
		respond_to do |format|
			format.html { redirect_to domains_url, notice: 'Domain was successfully destroyed.' }
		end
	end

	private
	def set_domain
		if current_user.admin
			@domain = Domain.friendly.find(params[:id])
		else
			@domain = current_user.domains.friendly.find(params[:id])
		end

	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def domain_params
		params.require(:domain).permit(:name, :description)
	end

end
