class CreatePieces < ActiveRecord::Migration[8.0]
  def change
    create_table :pieces do |t|
      t.string :title
      t.string :form
      t.string :date
      t.string :textsource
      t.string :imgsource

      t.timestamps
    end
  end
end
