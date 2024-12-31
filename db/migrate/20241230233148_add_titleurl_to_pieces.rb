class AddTitleurlToPieces < ActiveRecord::Migration[8.0]
  def change
    add_column :pieces, :titleurl, :string
  end
end
