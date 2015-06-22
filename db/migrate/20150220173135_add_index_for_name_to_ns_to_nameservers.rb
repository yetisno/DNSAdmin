class AddIndexForNameToNsToNameservers < ActiveRecord::Migration
	def change
		add_index :nameservers, [:name, :to_ns], unique: true
	end
end
