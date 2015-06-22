class CreateNameservers < ActiveRecord::Migration
  def change
    create_table :nameservers do |t|
      t.integer :domain_id
      t.string :name
      t.string :to_ns

      t.timestamps null: false
    end
  end
end
