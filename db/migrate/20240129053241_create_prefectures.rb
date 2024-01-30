class CreatePrefectures < ActiveRecord::Migration[6.1]
  def change
    create_table :prefectures do |t|
      t.string :large_service_area
      t.string :service_area_code
      t.string :name

      t.timestamps
    end
  end
end
