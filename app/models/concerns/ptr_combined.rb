module PtrCombined
	extend ActiveSupport::Concern

	included do
		after_create :add_ptr
		after_destroy :remove_ptr
	end

	def add_ptr
		Ptr.create!(a_id: id, ip_arpa: to_ip.split('.').reverse.inject { |ret, nxt| ret + ".#{nxt}" } + '.in-addr.arpa', to_name: name)
	end

	def remove_ptr
		Ptr.find_by(a_id: id).destroy!
	end
end
