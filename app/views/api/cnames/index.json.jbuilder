json.counts @cnames.count
json.data @cnames do |cname|
	json.extract! cname, :id, :domain_id, :name, :to_name
	json.url api_domain_cname_path(@domain, cname)
end
