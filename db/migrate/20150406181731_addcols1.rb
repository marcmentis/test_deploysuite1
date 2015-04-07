class Addcols1 < ActiveRecord::Migration
  def change
  	add_column :patients, :col1, :string
  end
end
