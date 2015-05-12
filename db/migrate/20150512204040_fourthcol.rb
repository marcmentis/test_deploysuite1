class Fourthcol < ActiveRecord::Migration
  def change
  	add_column :patients, :col4, :string
  end
end
