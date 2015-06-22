class AddIndexForDomainIdToSoas < ActiveRecord::Migration
	def change
		add_index :soas, :domain_id, unique: true
	end
end
