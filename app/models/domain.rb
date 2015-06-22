class Domain < ActiveRecord::Base
	extend FriendlyId
	friendly_id :name, use: :slugged
	has_many :user_domain_maps, dependent: :destroy
	has_many :users, :through => :user_domain_maps
	has_one :soa, dependent: :destroy
	has_many :as, dependent: :destroy
	has_many :cnames, dependent: :destroy
	has_many :mxes, dependent: :destroy
	has_many :nameservers, dependent: :destroy
	has_many :ddns, dependent: :destroy
	validates :name, presence: true

	def url_name
		name.gsub '.', '-'
	end

	def self.r_url_name(name)
		name.gsub '-', '.'
	end
end
