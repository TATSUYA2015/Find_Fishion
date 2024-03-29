class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|

      t.integer :genre_id,        null: false
      t.integer :contributor_id,  null: false
      t.string :name,             null: false, default: ""
      t.text :introduction

      t.timestamps
    end
  end
end
