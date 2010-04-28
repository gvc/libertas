class CreatePessoas < ActiveRecord::Migration
  def self.up
    create_table :pessoas do |t|
      t.string :nome
      t.string :email
      t.string :username
      t.string :senha
      t.string :cpf
      t.string :sexo
      t.date :data_nascimento
      t.integer :endereco_id
    end
    execute %{alter table pessoas
      add constraint fk_pessoas_enderecos foreign key (endereco_id) references enderecos(id)}
  end

  def self.down
    drop_table :pessoas
  end
end
