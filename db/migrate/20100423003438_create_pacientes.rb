class CreatePacientes < ActiveRecord::Migration
  def self.up
    create_table :pacientes do |t|
      t.integer :pessoa_id
    end
    execute %{alter table pacientes
      add constraint fk_pacientes_pessoas foreign key (pessoa_id) references pessoas(id)}
  end

  def self.down
    drop_table :pacientes
  end
end
