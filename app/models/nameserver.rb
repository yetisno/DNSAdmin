class Nameserver < ActiveRecord::Base
	belongs_to :domain
	validates :domain_id, presence: true
	validates :name, presence: true
	validates :to_ns, presence: true
end
