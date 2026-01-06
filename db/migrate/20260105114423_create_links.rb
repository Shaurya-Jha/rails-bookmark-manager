class CreateLinks < ActiveRecord::Migration[8.0]
  def change
    create_table :links do |t|
      t.string :url
      t.string :title
      t.text :note
      t.datetime :last_resurfaced_at
      t.boolean :archived

      t.timestamps
    end
  end
end
