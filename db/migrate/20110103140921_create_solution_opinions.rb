class CreateSolutionOpinions < ActiveRecord::Migration
  def self.up
    create_table :solution_opinions do |t|
      t.integer :authority_id

      t.timestamps
    end
  end

  def self.down
    drop_table :solution_opinions
  end
end
