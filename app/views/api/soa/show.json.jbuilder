json.count 1
json.data @soa, :id, :domain_id, :name, :contact, :serial, :refresh, :retry, :expire, :minimum
json.url api_domain_soa_path(@domain, @soa)
