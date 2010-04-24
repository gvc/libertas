class CreateTelefones < ActiveRecord::Migration
  def self.up
    create_table :telefones do |t|
      t.integer :pessoa_id
      t.string :codigo_area
      t.string :telefone
      t.boolean :is_celular

      t.timestamps
    end
  end

  def self.down
    drop_table :telefones
  end
end
