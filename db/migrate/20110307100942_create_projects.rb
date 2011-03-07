class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :name
      t.integer :tb_id
    end
  end

  def self.down
    drop_table :projects
  end
end
