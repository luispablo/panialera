# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120507233938) do

  create_table "barrios", :force => true do |t|
    t.string   "nombre"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "categorias", :force => true do |t|
    t.string   "codigo"
    t.string   "nombre"
    t.string   "descripcion"
    t.integer  "categoria_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "categorias", ["categoria_id"], :name => "index_categorias_on_categoria_id"

  create_table "domicilios", :force => true do |t|
    t.string   "nombre"
    t.string   "calle"
    t.integer  "numero"
    t.string   "piso"
    t.string   "depto"
    t.string   "entre_calles"
    t.string   "codigo_postal"
    t.integer  "barrio_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "usuario_id"
  end

  add_index "domicilios", ["barrio_id"], :name => "index_domicilios_on_barrio_id"

  create_table "productos", :force => true do |t|
    t.string   "codigo"
    t.string   "nombre"
    t.string   "descripcion"
    t.string   "detalle"
    t.float    "precio"
    t.string   "referencia"
    t.boolean  "disponible"
    t.boolean  "publicado"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "usuarios", :force => true do |t|
    t.string   "nombre"
    t.string   "apellido"
    t.string   "sexo"
    t.string   "tel_particular"
    t.string   "tel_celular"
    t.string   "email"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

end
