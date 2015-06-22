json.counts @as.count
json.data @as do |a|
	json.extract! a, :id, :domain_id, :name, :to_ip, :ddn_id
	json.url api_domain_a_path(@domain, a)
end
