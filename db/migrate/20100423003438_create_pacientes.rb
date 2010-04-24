class CreatePacientes < ActiveRecord::Migration
  def self.up
    create_table :pacientes do |t|
      t.integer :pessoa_id
      t.timestamps
    end
  end

  def self.down
    drop_table :pacientes
  end
end
