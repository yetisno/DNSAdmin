class CreateUserDomainMaps < ActiveRecord::Migration
  def change
    create_table :user_domain_maps do |t|
      t.integer :user_id
      t.integer :domain_id

      t.timestamps null: false
    end
  end
end
