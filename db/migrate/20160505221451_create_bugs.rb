class CreateBugs < ActiveRecord::Migration
  def change
    create_table :bugs do |t|
      t.string :application_token, index: true
      t.string :number, index: true
      t.integer :status, default: 0
      t.integer :priority, default: 0

      t.timestamps null: false
    end
    add_index :bugs, [:application_token, :number], unique: true
  end
end
