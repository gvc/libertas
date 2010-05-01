class CreateTerapeutas < ActiveRecord::Migration
  def self.up
    create_table :terapeutas do |t|
      t.integer :funcionario_id
      t.string :crp
    end
    execute %{alter table terapeutas
      add constraint fk_terapeutas_funcionarios foreign key (funcionario_id) references funcionarios(id)}
  end

  def self.down
    drop_table :terapeutas
  end
end
