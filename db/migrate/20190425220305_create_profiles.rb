class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :url
      t.string :username
      t.string :image

      t.timestamps
    end
  end
end
