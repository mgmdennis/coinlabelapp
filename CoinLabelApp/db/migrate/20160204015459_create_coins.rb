class CreateCoins < ActiveRecord::Migration
  def change
    create_table :coins do |t|
      t.text :fastinput
      t.string :country
      t.string :date
      t.string :denomination
      t.string :grade
      t.text :notes
      t.text :condition_notes
      t.string :mintage
      t.string :catalog_no
      
      t.text :other_notes
      t.string :diameter
      t.string :composition
      t.string :mass
      t.string :thickness
      t.string :shape
      t.string :orientation
      t.string :qrcode
      t.timestamps
    end
  end
end
