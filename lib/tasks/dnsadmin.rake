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
		if ActiveRecord::Base.connection.table_exists? 'as'
			Rake::Task['dns:db:migrate'].invoke
		else
			Rake::Task['dns:db:init'].invoke
		end

		pid = `cat unicorn.pid 2> /dev/null`
		if pid.empty?
			puts 'DNSAdmin Starting...'
			`unicorn_rails -E production -c config/unicorn.rb -D`
			puts 'DNSAdmin Started!!'
		else
			puts 'DNSAdmin is still running.'
		end
	end

	desc 'DNSAdmin | Run Application (Not Daemon)'
	task run: :environment do
		if ActiveRecord::Base.connection.table_exists? 'as'
			Rake::Task['dns:db:migrate'].invoke
		else
			Rake::Task['dns:db:init'].invoke
		end
		puts 'DNSAdmin Starting...'
		`unicorn_rails -E production -c config/unicorn.rb`
		puts 'DNSAdmin Started!!'
	end

	desc 'DNSAdmin | Stop Service'
	task stop: :environment do
		pid = `cat unicorn.pid 2> /dev/null`
		if pid.empty?
			puts 'DNSAdmin is not running.'
		else
			puts 'DNSAdmin Exiting...'
			`kill -QUIT #{pid} 2> /dev/null`
			sleep 5
			puts 'DNSAdmin Exited!!'
		end
	end

	desc 'DNSAdmin | Restart Service'
	task restart: :environment do
		Rake::Task['dns:stop'].invoke
		Rake::Task['dns:start'].invoke
	end
end
