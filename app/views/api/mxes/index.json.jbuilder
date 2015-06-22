json.counts @mxes.count
json.data @mxes do |mx|
	json.extract! mx, :id, :domain_id, :name, :priority, :to_name
	json.url api_domain_mx_path(@domain, mx)
end
