class CreateQueries < ActiveRecord::Migration
  def change
    create_table :queries do |t|
      t.integer :kind
      t.string :words
      t.string :category
      t.string :send_to_mail
      t.integer :response_status
      t.text :response_error

      t.timestamps null: false
    end
  end
end
