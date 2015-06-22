class CreateDdns < ActiveRecord::Migration
	def change
		create_table :ddns do |t|
			t.integer :domain_id
			t.string :device_name
			t.string :token

			t.timestamps null: false
		end

		add_index :ddns, :device_name, unique: true
		add_index :ddns, :token, unique: true
	end
end
