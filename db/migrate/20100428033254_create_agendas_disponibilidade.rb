class CreateAgendasDisponibilidade < ActiveRecord::Migration
  def self.up
    create_table :agendas_disponibilidade do |t|
      t.integer :terapeuta_id
      t.integer :dia_semana, :limit => 1
      t.time :hora_inicial
    end
    execute %{alter table agendas_disponibilidade
      add constraint fk_agendas_terapeutas foreign key (terapeuta_id) references terapeutas(id)}
  end

  def self.down
    drop_table :agendas_disponibilidade
  end
end
