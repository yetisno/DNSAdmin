json.counts @members.count
json.data @members do |member|
	json.extract! member, :id, :username, :email
	json.url api_domain_member_path(@domain, member)
end
