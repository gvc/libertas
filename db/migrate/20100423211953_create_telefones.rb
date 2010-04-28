class CreateTelefones < ActiveRecord::Migration
  def self.up
    create_table :telefones do |t|
      t.integer :pessoa_id
      t.string :codigo_area, :limit => 2
      t.string :telefone, :limit => 8
      t.boolean :is_celular
    end
    execute %{alter table telefones
      add constraint fk_telefones_pessoas foreign key (pessoa_id) references pessoas(id)}
  end

  def self.down
    drop_table :telefones
  end
end
