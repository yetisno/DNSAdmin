class ApiController < ApplicationController
	require_relative '../../lib/dn_service_operation'
	protect_from_forgery with: :null_session, if: lambda { request.format.json? }
end