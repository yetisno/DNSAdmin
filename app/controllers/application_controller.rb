# noinspection ALL
class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

	before_action :add_users_column, if: :devise_controller?

	def admin?
		!current_user.blank? && current_user.admin
	end

	def isJson?
		request.content_type == 'application/json' || request.format.json?
	end

	def add_users_column
		# devise_parameter_sanitizer.for(:sign_up) << :username
		# devise_parameter_sanitizer.for(:account_update) << :username
		devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
		devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
		devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password, :admin) }

	end
end

