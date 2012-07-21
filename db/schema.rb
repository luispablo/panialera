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

ActiveRecord::Schema.define(:version => 20120721201403) do

  create_table "barrios", :force => true do |t|
    t.string   "nombre"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "carrito_items", :force => true do |t|
    t.integer  "producto_id"
    t.integer  "carrito_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.float    "cantidad"
    t.integer  "combo_id"
  end

  add_index "carrito_items", ["carrito_id"], :name => "index_carrito_items_on_carrito_id"
  add_index "carrito_items", ["producto_id"], :name => "index_carrito_items_on_producto_id"

  create_table "carritos", :force => true do |t|
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "domicilio_id"
    t.date     "fecha_entrega"
    t.time     "hora_desde_entrega"
    t.time     "hora_hasta_entrega"
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
    t.boolean  "publicado"
    t.integer  "orden"
  end

  add_index "categorias", ["categoria_id"], :name => "index_categorias_on_categoria_id"

  create_table "combo_detalles", :force => true do |t|
    t.integer  "producto_id"
    t.integer  "cantidad"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "combo_id"
  end

  add_index "combo_detalles", ["producto_id"], :name => "index_combo_detalles_on_producto_id"

  create_table "combos", :force => true do |t|
    t.string   "codigo"
    t.float    "precio"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "imagen"
    t.string   "nombre"
    t.boolean  "publicado"
    t.float    "stock"
  end

  create_table "compra_detalles", :force => true do |t|
    t.integer  "compra_id"
    t.integer  "producto_id"
    t.float    "cantidad"
    t.float    "precio"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "compra_detalles", ["compra_id"], :name => "index_compra_detalles_on_compra_id"
  add_index "compra_detalles", ["producto_id"], :name => "index_compra_detalles_on_producto_id"

  create_table "compras", :force => true do |t|
    t.datetime "fecha"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "proveedor_id"
  end

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
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "usuario_id"
    t.boolean  "ultima_entrega"
    t.boolean  "valido_delivery"
    t.datetime "deleted_at"
  end

  add_index "domicilios", ["barrio_id"], :name => "index_domicilios_on_barrio_id"

  create_table "entregas", :force => true do |t|
    t.integer  "wday"
    t.time     "desde"
    t.time     "hasta"
    t.boolean  "disponible"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "excepcion_entregas", :force => true do |t|
    t.date     "fecha"
    t.time     "hora_desde"
    t.time     "hora_hasta"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

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

  create_table "parametros", :force => true do |t|
    t.string   "codigo"
    t.string   "nombre"
    t.string   "valor"
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
    t.string   "talle"
    t.string   "peso_bebe"
    t.string   "edad_bebe"
    t.boolean  "destacado"
    t.boolean  "oferta"
    t.float    "stock"
  end

  create_table "proveedores", :force => true do |t|
    t.string   "nombre"
    t.string   "direccion"
    t.string   "telefono"
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "pagina_web"
  end

  create_table "usuarios", :force => true do |t|
    t.string   "nombre"
    t.string   "apellido"
    t.string   "sexo"
    t.string   "tel_particular"
    t.string   "tel_celular"
    t.string   "email"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "tel_laboral"
    t.string   "password_digest"
    t.boolean  "administrador"
  end

  create_table "vales", :force => true do |t|
    t.string   "codigo"
    t.string   "nombre"
    t.string   "descripcion"
    t.float    "valor"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "usuario_id"
  end

  create_table "venta_detalles", :force => true do |t|
    t.integer  "venta_id"
    t.integer  "producto_id"
    t.float    "cantidad"
    t.float    "precio"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "combo_id"
  end

  add_index "venta_detalles", ["producto_id"], :name => "index_venta_detalles_on_producto_id"
  add_index "venta_detalles", ["venta_id"], :name => "index_venta_detalles_on_venta_id"

  create_table "ventas", :force => true do |t|
    t.date     "fecha"
    t.integer  "usuario_id"
    t.integer  "domicilio_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.boolean  "confirmada"
    t.date     "fecha_entrega"
    t.time     "hora_desde_entrega"
    t.time     "hora_hasta_entrega"
    t.float    "costo_envio"
    t.string   "comentarios"
    t.boolean  "entregada"
  end

  add_index "ventas", ["domicilio_id"], :name => "index_ventas_on_domicilio_id"
  add_index "ventas", ["usuario_id"], :name => "index_ventas_on_usuario_id"

end
