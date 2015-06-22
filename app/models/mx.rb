class Mx < ActiveRecord::Base
	belongs_to :domain
	validates :domain_id, presence: true
	validates :name, presence: true
	validates :priority, presence: true, numericality: :only_integer
	validates :to_name, presence: true
end
