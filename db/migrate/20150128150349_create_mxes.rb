class CreateMxes < ActiveRecord::Migration
  def change
    create_table :mxes do |t|
      t.integer :domain_id
      t.string :name
      t.integer :priority
      t.string :to_name

      t.timestamps null: false
    end
  end
end
