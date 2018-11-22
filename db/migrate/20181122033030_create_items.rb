class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.text :content
      t.date :date
      t.boolean :starred

      t.timestamps
    end
  end
end
