json.counts @ptrs.count
json.data @ptrs do |ptr|
	json.extract! ptr, :id, :ip_arpa, :to_name
end
