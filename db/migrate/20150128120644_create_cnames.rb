class CreateCnames < ActiveRecord::Migration
  def change
    create_table :cnames do |t|
      t.integer :domain_id
      t.string :name
      t.string :to_name

      t.timestamps null: false
    end
  end
end
