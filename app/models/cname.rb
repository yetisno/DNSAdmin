class Cname < ActiveRecord::Base
	belongs_to :domain
	validates :domain_id, presence: true
	validates :name, presence: true
	validates :to_name, presence: true
end
