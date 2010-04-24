class CreatePessoas < ActiveRecord::Migration
  def self.up
    create_table :pessoas do |t|
      t.text :nome
      t.text :email
      t.text :login
      t.text :senha
      t.string :cpf
      t.string :sexo
      t.date :data_nascimento

      t.timestamps
    end
  end

  def self.down
    drop_table :pessoas
  end
end
