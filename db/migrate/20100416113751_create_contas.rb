class CreateContas < ActiveRecord::Migration
  def self.up
    create_table :contas do |t|
      t.text :descricao
      t.date :data_vencimento
      t.date :data_pagamento
      t.string :tipo_conta
      t.decimal :valor, :scale => 6, :precision => 2
      t.timestamps
    end
  end

  def self.down
    drop_table :contas
  end
end
