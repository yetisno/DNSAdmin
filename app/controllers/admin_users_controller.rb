class AdminUsersController < ApplicationController
	include Loginable
	before_action :set_default
	before_action :check_admin
	before_action :set_user, only: [:show, :edit, :destroy, :update]

	# GET /admin_users
	# GET /admin_users.json
	def index
		@users = User.all
	end

	# GET /admin_users/1.json
	def show
		@domains = @user.domains.all;
	end

	# GET /admin_users/new
	def new
		@user = User.new
		@rstring = SecureRandom.base64 6
	end

	# GET /admin_users/1/edit
	def edit
	end

	# POST /admin_users
	# POST /admin_users.json
	def create
		@user = User.new(params.require(:user).permit(:username, :email, :admin, :password, :password_confirmation))
		@user.save
		if !@user.errors.blank?
			error = ''
			@user.errors.messages.each do |key, message|
				error += "#{key} #{message.first}, "
			end
			flash[:alert] = error
			render action: 'new'
		else
			redirect_to admin_users_path
		end
	end

	def update
		begin
			if params.require(:user)[:password].blank?
				@user.update! params.require(:user).permit(:email, :admin)
			else
				@user.update! params.require(:user).permit(:email, :admin, :password, :password_confirmation)
			end
			redirect_to @user.admin ? admin_users_path : root_path

		rescue Exception => ex
			flash[:alert] = ex.message
			render :edit
		end
	end

	def destroy
		if @user.id == @current_user.id
			flash[:alert] = "Can't delete yourself."
			redirect_to :back
		else
			@user.destroy!
			redirect_to :back
		end
	end

	def set_user
		@user = User.friendly.find(params[:id])
	end

	def set_default
		@current_user = current_user
		@errors = @current_user.errors.messages
	end

	def check_admin
		redirect_to root unless @current_user.admin
	end
end

