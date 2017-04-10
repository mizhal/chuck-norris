class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.string :icon_url
      t.string :remote_id
      t.string :url
      t.text :value
      t.integer :query_id

      t.timestamps null: false
    end
  end
end
