class AddThirdCol < ActiveRecord::Migration
  def change
  	add_column :patients, :col3, :string
  end
end
