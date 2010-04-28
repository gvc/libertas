class CreateContas < ActiveRecord::Migration
  def self.up
    create_table :contas do |t|
      t.text :descricao
      t.date :data_vencimento
      t.date :data_pagamento
      t.string :tipo_conta, :limit => 1
      t.decimal :valor, :scale => 2, :precision => 6
    end
  end

  def self.down
    drop_table :contas
  end
end
