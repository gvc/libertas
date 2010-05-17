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

ActiveRecord::Schema.define(:version => 20100428033254) do

  create_table "agendas_disponibilidade", :force => true do |t|
    t.integer "terapeuta_id"
    t.integer "dia_semana",   :limit => 1
    t.time    "hora_inicial"
  end

  add_index "agendas_disponibilidade", ["terapeuta_id"], :name => "fk_agendas_terapeutas"

  create_table "consultas", :force => true do |t|
    t.integer  "paciente_id"
    t.integer  "terapeuta_id"
    t.datetime "data_consulta"
    t.datetime "data_marcacao"
    t.text     "observacoes"
  end

  add_index "consultas", ["paciente_id"], :name => "fk_consultas_pacientes"
  add_index "consultas", ["terapeuta_id"], :name => "fk_consultas_terapeutas"

  create_table "contas", :force => true do |t|
    t.string  "descricao"
    t.date    "data_vencimento"
    t.date    "data_pagamento"
    t.string  "tipo_conta",      :limit => 1
    t.decimal "valor",                        :precision => 6, :scale => 2
  end

  create_table "enderecos", :force => true do |t|
    t.integer "pessoa_id"
    t.string  "rua"
    t.string  "bairro"
    t.string  "cidade"
    t.string  "estado"
    t.string  "cep",         :limit => 8
    t.string  "numero"
    t.string  "complemento"
  end

  add_index "enderecos", ["pessoa_id"], :name => "fk_enderecos_pessoas"

  create_table "funcionarios", :force => true do |t|
    t.integer "pessoa_id"
    t.decimal "salario",                       :precision => 6, :scale => 2
    t.string  "rg",               :limit => 7
    t.date    "data_contratacao"
    t.boolean "admin"
  end

  add_index "funcionarios", ["pessoa_id"], :name => "fk_funcionarios_pessoas"

  create_table "pacientes", :force => true do |t|
    t.integer "pessoa_id"
  end

  add_index "pacientes", ["pessoa_id"], :name => "fk_pacientes_pessoas"

  create_table "pessoas", :force => true do |t|
    t.string "nome"
    t.string "email"
    t.string "username"
    t.string "senha"
    t.string "cpf",             :limit => 11
    t.string "sexo",            :limit => 1
    t.date   "data_nascimento"
  end

  create_table "telefones", :force => true do |t|
    t.integer "pessoa_id"
    t.string  "codigo_area", :limit => 2
    t.string  "telefone",    :limit => 8
    t.boolean "celular"
  end

  add_index "telefones", ["pessoa_id"], :name => "fk_telefones_pessoas"

  create_table "terapeutas", :force => true do |t|
    t.integer "funcionario_id"
    t.string  "crp"
  end

  add_index "terapeutas", ["funcionario_id"], :name => "fk_terapeutas_funcionarios"

end
