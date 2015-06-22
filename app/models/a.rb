class A < ActiveRecord::Base
	require 'resolv'
	include PtrCombined
	belongs_to :domain
	belongs_to :ddn
	validates :domain_id, presence: true
	validates :name, presence: true
	validates :to_ip, presence: true, :format => {:with => Resolv::IPv4::Regex}
end
