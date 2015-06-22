class CreatePtrs < ActiveRecord::Migration
  def change
    create_table :ptrs do |t|
      t.integer :domain_id
      t.string :ip_arpa
      t.string :to_name

      t.timestamps null: false
    end
  end
end
