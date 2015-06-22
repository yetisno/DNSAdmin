class CreateDomains < ActiveRecord::Migration
  def change
    create_table :domains do |t|
      t.string :name
      t.text :description

      t.timestamps null: false
    end
  end
end
