class User < ActiveRecord::Base
	extend FriendlyId
	friendly_id :username, use: :slugged
	# Include default devise modules. Others available are:
	# :token_authenticatable, :confirmable, :registerable, :recoverable,
	# :lockable, :timeoutable and :omniauthable,
	devise :database_authenticatable,
	       :rememberable, :trackable, :validatable,
	       :authentication_keys => [:login]
	has_many :user_domain_maps
	has_many :domains, :through => :user_domain_maps
	attr_accessor :login
	validates :username, presence: true, uniqueness: {case_sensitive: false}
	validates :email, presence: true
	validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
	validates :admin, :inclusion => {in: [true, false]}

	def self.find_for_database_authentication(warden_conditions)
		conditions = warden_conditions.dup
		if login = conditions.delete(:login)
			where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", {:value => login.downcase}]).first
		else
			where(conditions.to_h).first
		end
	end
end
