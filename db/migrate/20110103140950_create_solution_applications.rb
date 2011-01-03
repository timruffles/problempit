class CreateSolutionApplications < ActiveRecord::Migration
  def self.up
    create_table :solution_applications do |t|
      t.integer :solution_opinion_id
      t.integer :solution_id

      t.timestamps
    end
  end

  def self.down
    drop_table :solution_applications
  end
end
