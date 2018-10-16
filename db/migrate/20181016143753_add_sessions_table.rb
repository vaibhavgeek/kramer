class AddSessionsTable < ActiveRecord::Migration[4.2]
  def change
    create_table :sessions_ar do |t|
      t.string :session_id, :null => false
      t.boolean :persistent
      t.text :data
      t.timestamps
    end
    add_index :sessions_ar, :persistent
    add_index :sessions_ar, :session_id
    add_index :sessions_ar, :updated_at
  end
end
