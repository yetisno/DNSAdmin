class CreateAs < ActiveRecord::Migration
  def change
    create_table :as do |t|
      t.integer :domain_id
      t.string :name
      t.string :to_ip

      t.timestamps null: false
    end
  end
end
