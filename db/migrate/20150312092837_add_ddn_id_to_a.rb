class AddDdnIdToA < ActiveRecord::Migration
  def change
	  add_column :as, :ddn_id, :integer
  end
end
