class CreateSoas < ActiveRecord::Migration
  def change
    create_table :soas do |t|
      t.integer :domain_id
      t.string :name
      t.string :contact
      t.integer :serial
      t.integer :refresh
      t.integer :retry
      t.integer :expire
      t.integer :minimum

      t.timestamps null: false
    end
  end
end
