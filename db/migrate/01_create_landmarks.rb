class CreateLandmarks < ActiveRecord::Migration
  def change 
    create_table :landmarks do |t|
      t.string :name
      t.integer :year_completed
    end
  end
end
