class AddIndexForNamePriorityToNameToMxes < ActiveRecord::Migration
	def change
		add_index :mxes, [:name, :priority, :to_name], unique: true
	end
end
