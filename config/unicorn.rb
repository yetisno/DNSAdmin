# ENV['RAILS_RELATIVE_URL_ROOT'] = "/dnsmanager"
require 'active_record'
require 'active_support/core_ext'
require 'YAML'

worker_processes Integer(ENV["WEB_CONCURRENCY"] || 1)
timeout 60
CONFIG = YAML.load(ERB.new(File.read(File.join('config','dnsadmin.yml'))).result)['dnsadmin']
preload_app true
GC.respond_to?(:copy_on_write_friendly=) and
	GC.copy_on_write_friendly = true
check_client_connection false

listen "#{CONFIG['bind-ip']}:#{CONFIG['bind-port']}", :tcp_nopush => true
pid 'unicorn.pid'

before_fork do |server, worker|
	Signal.trap 'TERM' do
		puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
		Process.kill 'QUIT', Process.pid
	end

	defined?(ActiveRecord::Base) and
		ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
	Signal.trap 'TERM' do
		puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
	end

	defined?(ActiveRecord::Base) and
		ActiveRecord::Base.establish_connection
end
