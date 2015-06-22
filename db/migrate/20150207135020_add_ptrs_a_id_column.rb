class AddPtrsAIdColumn < ActiveRecord::Migration
  def change
    add_column :ptrs, :a_id, :integer
  end
end
