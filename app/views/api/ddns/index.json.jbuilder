json.counts @ddns.count
json.data @ddns do |ddn|
	json.id ddn.id
	json.domain_id ddn.domain_id
	json.a_id ddn.a.id
	json.device_name ddn.device_name
	json.token ddn.token
	json.name ddn.a.name
	json.to_ip ddn.a.to_ip
	json.url api_domain_ddn_path(@domain, ddn.token)
end
