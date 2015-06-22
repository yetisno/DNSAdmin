json.counts @nameservers.count
json.data @nameservers do |nameserver|
	json.extract! nameserver, :id, :domain_id, :name, :to_ns
	json.url api_domain_nameserver_path(@domain, nameserver)
end
