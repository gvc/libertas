# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100423211953) do

  create_table "contas", :force => true do |t|
    t.text     "descricao"
    t.date     "data_vencimento"
    t.date     "data_pagamento"
    t.string   "tipo_conta"
    t.decimal  "valor",           :precision => 2, :scale => 6
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "enderecos", :force => true do |t|
    t.integer  "pessoa_id"
    t.text     "rua"
    t.text     "cidade"
    t.text     "bairro"
    t.text     "estado"
    t.string   "cep"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pacientes", :force => true do |t|
    t.integer  "pessoa_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pessoas", :force => true do |t|
    t.text     "nome"
    t.text     "email"
    t.text     "login"
    t.text     "senha"
    t.string   "cpf"
    t.string   "sexo"
    t.date     "data_nascimento"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "telefones", :force => true do |t|
    t.integer  "pessoa_id"
    t.string   "codigo_area"
    t.string   "telefone"
    t.boolean  "is_celular"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end