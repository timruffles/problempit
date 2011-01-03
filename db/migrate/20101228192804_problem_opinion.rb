class ProblemOpinion < ActiveRecord::Migration
  def self.up
    create_table :problem_opinions do |t|
      t.string  :who
      t.integer :who_size
      t.integer :pain
      t.integer :awareness
      t.integer :solved
      t.integer :growth
      t.integer :authority_id
    end
  end

  def self.down
    drop_table :problem_opinions
  end
end
