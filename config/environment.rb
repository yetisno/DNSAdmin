# Load the Rails application.
require File.expand_path('../application', __FILE__)
require 'extensions/object'

# Initialize the Rails application.
Rails.application.initialize!

Rails.application.assets.context_class.class_eval do
	include ActionView::Helpers
	include Rails.application.routes.url_helpers
end

$run_dns = true
$sider_pages = ['domains#index']
$open_access_pages = ['ddns#update']
