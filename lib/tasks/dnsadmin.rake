def alive?(pid)
	begin
		Process.getpgid(pid.to_i)
		true
	rescue
		false
	end
end

def load_conf
	require 'active_support/core_ext/string/output_safety'
	require 'yaml'
	YAML.load(ERB.new(File.read(File.join('config', 'dnsadmin.yml'))).result)
end

def checkConfig
	conf=load_conf
	if ENV['DNS_DATABASE_URL'].nil?
		raise "DNS_DATABASE_URL can't be empty. Please set it at config/database.yml"
	end
	if conf['dnservice']['reload-key'].nil?
		require 'securerandom'
		secret = SecureRandom.hex(64)
		raise "reload-key can't be empty. you can set reload-key: #{secret} at config/dnsadmin.yml or use environment variable DNS_RELOAD_KEY"
	end
	if ENV['SECRET_KEY_BASE'].nil?
		require 'securerandom'
		secret = SecureRandom.hex(64)
		raise "config.secret_key = '#{secret}'

Please ensure you restarted your application after installing Devise or setting the key."
	end
end

namespace :dns do
	namespace :db do
		desc 'DNSAdmin | Rebuild DB'
		task rebuild: :environment do
			Rake::Task['dns:db:drop'].invoke
			Rake::Task['dns:db:init'].invoke
		end

		desc 'DNSAdmin | Migrate DB'
		task migrate: :environment do
			Rake::Task['db:migrate'].invoke
		end

		desc 'DNSAdmin | Build DB'
		task init: :environment do
			Rake::Task['db:migrate'].invoke
			Rake::Task['db:seed'].invoke
		end

		desc 'DNSAdmin | Drop DB'
		task drop: :environment do
			Rake::Task['db:drop'].invoke
		end
	end

	desc 'DNSAdmin | Start Service'
	task start: :environment do
		checkConfig
		if ActiveRecord::Base.connection.table_exists? 'as'
			Rake::Task['dns:db:migrate'].invoke
		else
			Rake::Task['dns:db:init'].invoke
		end
		pid = `cat unicorn.pid 2> /dev/null`
		if alive?(pid) && !pid.empty?
			puts 'DNSAdmin is still running.'
		else
			puts 'DNSAdmin Starting...'
			`unicorn_rails -E production -c config/unicorn.rb -D`
			puts 'DNSAdmin Started!!'
		end
	end

	desc 'DNSAdmin | Run Application (Not Daemon)'
	task run: :environment do
		checkConfig
		if ActiveRecord::Base.connection.table_exists? 'as'
			Rake::Task['dns:db:migrate'].invoke
		else
			Rake::Task['dns:db:init'].invoke
		end
		pid = `cat unicorn.pid 2> /dev/null`
		if alive?(pid) && !pid.empty?
			puts 'DNSAdmin is still running.'
		else
			puts 'DNSAdmin Starting...'
			`unicorn_rails -E production -c config/unicorn.rb`
		end
	end

	desc 'DNSAdmin | Stop Service'
	task stop: :environment do
		pid = `cat unicorn.pid 2> /dev/null`
		if alive?(pid) && !pid.empty?
			puts 'DNSAdmin Exiting...'
			`kill -QUIT #{pid} 2> /dev/null`
			sleep 5
			puts 'DNSAdmin Exited!!'
		else
			puts 'DNSAdmin is not running.'
		end
	end

	desc 'DNSAdmin | Restart Service'
	task restart: :environment do
		Rake::Task['dns:stop'].invoke
		Rake::Task['dns:start'].invoke
	end
end
