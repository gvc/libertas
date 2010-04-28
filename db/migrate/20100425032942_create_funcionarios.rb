class CreateFuncionarios < ActiveRecord::Migration
  def self.up
    create_table :funcionarios do |t|
      t.integer :pessoa_id
      t.decimal :salario, :precision => 6, :scale => 2
      t.integer :rg, :limit => 7
      t.date :data_contratacao
      t.boolean :admin
    end
    execute %{alter table funcionarios
      add constraint fk_funcionarios_pessoas foreign key (pessoa_id) references pessoas(id)}
  end

  def self.down
    drop_table :funcionarios
  end
end
