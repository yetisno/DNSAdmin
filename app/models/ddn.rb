class Ddn < ActiveRecord::Base
	belongs_to :domain
	has_one :a, dependent: :destroy
	validates :domain_id, presence: true
	validates :device_name, presence: true
end
