class AddIndexOfNameWithToNameToCnames < ActiveRecord::Migration
  def change
	  add_index :cnames, [:name, :to_name], unique: true
  end
end
