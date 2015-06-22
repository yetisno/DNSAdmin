class AddIndexToUserDomainMaps < ActiveRecord::Migration
	def change
		add_index :user_domain_maps, [:domain_id, :user_id], unique: true
	end
end
