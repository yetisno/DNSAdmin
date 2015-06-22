class AddIndexOfNameWithToIpToAs < ActiveRecord::Migration
  def change
	  add_index :as, [:name, :to_ip], unique: true
  end
end
