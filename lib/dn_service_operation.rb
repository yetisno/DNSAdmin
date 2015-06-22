require 'resolv'
class DNServiceOperation
	def self.reload
		conf = YAML.load(ERB.new(File.read(File.join('config', 'dnsadmin.yml'))).result)['dnservice']
		Resolv::DNS.open(nameserver_port: [[conf['ip'], conf['port']]]).
			getresources(conf['reload-key'], Resolv::DNS::Resource::IN::TXT)
	end
end