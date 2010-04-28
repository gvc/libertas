class CreateConsultas < ActiveRecord::Migration
  def self.up
    create_table :consultas do |t|
      t.integer :paciente_id
      t.integer :terapeuta_id
      t.date :data_consulta
      t.date :data_marcacao
      t.time :hora
      t.text :observacoes
    end
    execute %{alter table consultas
      add constraint fk_consultas_pacientes foreign key (paciente_id) references pacientes(id)}
    execute %{alter table consultas
      add constraint fk_consultas_terapeutas foreign key (terapeuta_id) references terapeutas(id)}
  end

  def self.down
    drop_table :consultas
  end
end
