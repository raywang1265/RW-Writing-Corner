class AddPreviewFieldsToPieces < ActiveRecord::Migration[8.0]
  def change
    add_column :pieces, :preview_text, :text
  end
end
