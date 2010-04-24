class CreateEnderecos < ActiveRecord::Migration
  def self.up
    create_table :enderecos do |t|
      t.integer :pessoa_id
      t.text :rua
      t.text :cidade
      t.text :bairro
      t.text :estado
      t.string :cep

      t.timestamps
    end
  end

  def self.down
    drop_table :enderecos
  end
end
