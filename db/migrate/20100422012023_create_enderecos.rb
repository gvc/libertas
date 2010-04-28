class CreateEnderecos < ActiveRecord::Migration
  def self.up
    create_table :enderecos do |t|
      t.string :rua
      t.string :bairro
      t.string :cidade
      t.string :estado
      t.integer :cep, :limit => 8
      t.integer :numero
      t.string :complemento
    end
  end

  def self.down
    drop_table :enderecos
  end
end
