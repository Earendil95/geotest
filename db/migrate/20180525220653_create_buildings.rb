class CreateBuildings < ActiveRecord::Migration[5.2]
  def change
    create_table :buildings do |t|
      t.string :address, null: false
      t.st_point :coordinates, null: false, geographic: true
    end

    add_index :buildings, :coordinates, using: :gist
  end
end
