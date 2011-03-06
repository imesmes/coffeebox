class CreateIntervals < ActiveRecord::Migration
  def self.up
    create_table :intervals do |t|
      t.datetime :start
      t.datetime :stop
      t.string :details
      t.boolean :billable
      t.integer :task_id

      t.timestamps
    end
  end

  def self.down
    drop_table :intervals
  end
end
