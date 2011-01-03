class CreateProblemLocations < ActiveRecord::Migration
  def self.up
    create_table :problem_locations do |t|
      t.string :name
      t.integer :parent_id

      t.timestamps
    end
  end

  def self.down
    drop_table :problem_locations
  end
end
