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

ActiveRecord::Schema.define(:version => 20120519153304) do

  create_table "barrios", :force => true do |t|
    t.string   "nombre"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "cat_productos", :force => true do |t|
    t.integer  "producto_id"
    t.integer  "categoria_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "cat_productos", ["categoria_id"], :name => "index_cat_productos_on_categoria_id"
  add_index "cat_productos", ["producto_id"], :name => "index_cat_productos_on_producto_id"

  create_table "categorias", :force => true do |t|
    t.string   "codigo"
    t.string   "nombre"
    t.string   "descripcion"
    t.integer  "categoria_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "categorias", ["categoria_id"], :name => "index_categorias_on_categoria_id"

  create_table "compras", :force => true do |t|
    t.datetime "fecha"
    t.integer  "usuario_id"
    t.integer  "domicilio_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "compras", ["domicilio_id"], :name => "index_compras_on_domicilio_id"
  add_index "compras", ["usuario_id"], :name => "index_compras_on_usuario_id"

  create_table "detalles_compras", :force => true do |t|
    t.integer  "compra_id"
    t.integer  "producto_id"
    t.integer  "cantidad"
    t.float    "precio"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "detalles_compras", ["compra_id"], :name => "index_detalles_compras_on_compra_id"
  add_index "detalles_compras", ["producto_id"], :name => "index_detalles_compras_on_producto_id"

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

  create_table "hijos", :force => true do |t|
    t.string   "nombre"
    t.string   "apellido"
    t.date     "fecha_nacimiento"
    t.string   "sexo"
    t.boolean  "usa_paniales"
    t.integer  "usuario_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "hijos", ["usuario_id"], :name => "index_hijos_on_usuario_id"

  create_table "marcas", :force => true do |t|
    t.string   "nombre"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

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
    t.integer  "marca_id"
    t.string   "imagen"
    t.integer  "stock"
    t.string   "talle"
    t.string   "peso_bebe"
    t.string   "edad_bebe"
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
    t.string   "tel_laboral"
  end

  create_table "vales", :force => true do |t|
    t.string   "codigo"
    t.string   "nombre"
    t.string   "descripcion"
    t.float    "valor"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

end
