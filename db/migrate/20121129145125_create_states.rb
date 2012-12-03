class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.string :capital
      t.string :name
      t.string :shortname
      t.references :country

      t.timestamps
    end
    add_index :states, :country_id
  end
end
