class AddThirdCol < ActiveRecord::Migration
  def change
  	add_column :patients, :col2, :string
  end
end
