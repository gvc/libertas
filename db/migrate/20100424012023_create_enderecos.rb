class CreateEnderecos < ActiveRecord::Migration
  def self.up
    create_table :enderecos do |t|
      t.integer :pessoa_id
      t.string :rua
      t.string :bairro
      t.string :cidade
      t.string :estado
      t.string :cep, :limit => 8
      t.string :numero
      t.string :complemento
    end
    execute %{alter table enderecos
      add constraint fk_enderecos_pessoas foreign key (pessoa_id) references pessoas(id)}
  end

  def self.down
    drop_table :enderecos
  end
end
