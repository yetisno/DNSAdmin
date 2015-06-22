require 'resolv'
class DNServiceOperation
	def self.reload
		begin
			conf = YAML.load(ERB.new(File.read(File.join('config', 'dnsadmin.yml'))).result)['dnservice']
			key = ''
			if conf['reload-key'].blank?
				if File.exist? File.join('..', 'DNService', 'db', 'dnservice.rkey')
					key = File.open(File.join('..', 'DNService', 'db', 'dnservice.rkey')).readline
				end
			else
				key = conf['reload-key']
			end
			Resolv::DNS.open(nameserver_port: [[conf['ip'], conf['port']]]).
				getresources(key, Resolv::DNS::Resource::IN::TXT)
		rescue
		end
	end
end
