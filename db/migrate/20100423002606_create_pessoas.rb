class CreatePessoas < ActiveRecord::Migration
  def self.up
    create_table :pessoas do |t|
      t.string :nome
      t.string :email
      t.string :username
      t.string :senha_hash
      t.string :sal
      t.string :cpf, :limit => '11'
      t.string :sexo, :limit => '1'
      t.date :data_nascimento
    end
  end

  def self.down
    drop_table :pessoas
  end
end
