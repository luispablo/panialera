Panialera::Application.routes.draw do

  resources :excepcion_entregas

  resources :combo_detalles

  resources :combos

  controller :combos do
    post '/combos/agregar_detalle' => :agregar_detalle
    delete '/combos/quitar_detalle/:id' => :quitar_detalle
    get '/combos/copiar/:combo_id' => :copiar
  end

  resources :proveedores

  resources :entregas

  resources :parametros

  resources :carrito_items

  resources :carritos

  get 'admin' => 'admin#index'

  controller :admin do
    get '/admin/domicilio_valido/:id' => :validar_domicilio
    get '/admin/domicilio_invalido/:id' => :invalidar_domicilio
    get '/admin/venta_entregada/:venta_id' => :venta_entregada
    get '/admin/venta_cancelada/:venta_id' => :venta_cancelada
    get '/admin/imprimir_proximas_entregas' => :imprimir_proximas_entregas
  end

  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
    get 'login_or_register' => :login_or_register
    get 'registro' => :registro
    post 'registrarme' => :create_usuario
  end

  match '/ventas/agregar_detalle', :to => 'ventas#agregar_detalle'
  match '/ventas/quitar_detalle/:id', :to => 'ventas#quitar_detalle'
  resources :ventas
  resources :venta_detalles
  
  controller :ventas do
    get 'cambiar_domicilio_entrega/:from/:to' => :cambiar_domicilio_entrega
    get '/confirmar_venta/:id' => :confirmar
  end

  match '/compras/agregar_detalle', :to => 'compras#agregar_detalle'
  match '/compras/quitar_detalle/:id', :to => 'compras#quitar_detalle'
  resources :compras
  resources :compra_detalles

  match '/productos/:id/categorias', :to => 'productos#categorias'
  match '/productos/agregar_categoria', :to => 'productos#agregar_categoria'
  match '/productos/quitar_categoria/:id', :to => 'productos#quitar_categoria'
  
  resources :marcas

  resources :detalles_compras

  resources :hijos

  resources :vales

  resources :domicilios

  resources :barrios

  resources :usuarios

  resources :productos
  
  controller :productos do
    get '/productos/copiar/:producto_id' => :copiar
  end
  
  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root to: 'tienda#index', as: 'tienda'

  controller :tienda do
    get 'productos_categoria/:codigo' => :productos_categoria
    post 'productos_categoria/:codigo' => :productos_categoria
    get 'detalle_producto/:codigo' => :detalle_producto
	get 'detalle_oferta/:combo_id' => :detalle_combo
    get 'contacto' => :contacto
    post 'contacto' => :contacto
    get 'nueva_compra/seleccionar_domicilio' => :seleccionar_domicilio
    get 'nueva_compra/entrega/:domicilio_id' => :entrega
    get 'nueva_compra/resumen/:domicilio_id/:entrega_id/:fecha' => :resumen
	post 'nueva_compra/resumen/:domicilio_id/:entrega_id/:fecha' => :resumen
    get 'nueva_compra/confirmar' => :confirmar
    post 'nueva_compra/confirmar' => :confirmar
    post 'nuevo_domicilio' => :nuevo_dom
    post 'busqueda' => :busqueda
    get 'alcance' => :alcance
    get 'nosotros' => :nosotros
    get 'ofertas' => :ofertas
    post 'ofertas' => :ofertas
	get 'destacados' => :destacados
	post 'destacados' => :destacados
	get 'servicios' => :servicios
	get 'preguntas' => :preguntas
  end

  controller :mi_cuenta do
    get 'mi_cuenta/datos_personales' => :datos_personales
    get 'mi_cuenta/pedidos' => :pedidos
    get 'mi_cuenta/pedidos/:venta_id' => :pedido
    get 'mi_cuenta/vales' => :vales
    get 'mi_cuenta/cambio_clave' => :cambio_clave
    post 'mi_cuenta/cambio_clave' => :cambio_clave
    
    get 'mi_cuenta/hijos/new' => :new_hijo
    get 'mi_cuenta/hijos/:hijo_id' => :edit_hijo
    post 'mi_cuenta/hijos' => :create_hijo
    put 'mi_cuenta/hijos/:hijo_id' => :update_hijo
    
    get 'mi_cuenta/domicilios' => :domicilios
    get 'mi_cuenta/domicilios/new' => :new_domicilio
    post 'mi_cuenta/domicilios' => :create_domicilio
	delete 'mi_cuenta/domicilios/:dom_id' => :delete_domicilio
    get 'mi_cuenta/domicilios/:dom_id' => :edit_domicilio
    put 'mi_cuenta/domicilios/:dom_id' => :update_domicilio
  end

  resources :categorias

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
end
#== Route Map
# Generated on 10 Sep 2012 20:16
#
#                                    POST   /excepcion_entregas(.:format)                                    excepcion_entregas#create
#              new_excepcion_entrega GET    /excepcion_entregas/new(.:format)                                excepcion_entregas#new
#             edit_excepcion_entrega GET    /excepcion_entregas/:id/edit(.:format)                           excepcion_entregas#edit
#                  excepcion_entrega GET    /excepcion_entregas/:id(.:format)                                excepcion_entregas#show
#                                    PUT    /excepcion_entregas/:id(.:format)                                excepcion_entregas#update
#                                    DELETE /excepcion_entregas/:id(.:format)                                excepcion_entregas#destroy
#                     combo_detalles GET    /combo_detalles(.:format)                                        combo_detalles#index
#                                    POST   /combo_detalles(.:format)                                        combo_detalles#create
#                  new_combo_detalle GET    /combo_detalles/new(.:format)                                    combo_detalles#new
#                 edit_combo_detalle GET    /combo_detalles/:id/edit(.:format)                               combo_detalles#edit
#                      combo_detalle GET    /combo_detalles/:id(.:format)                                    combo_detalles#show
#                                    PUT    /combo_detalles/:id(.:format)                                    combo_detalles#update
#                                    DELETE /combo_detalles/:id(.:format)                                    combo_detalles#destroy
#                             combos GET    /combos(.:format)                                                combos#index
#                                    POST   /combos(.:format)                                                combos#create
#                          new_combo GET    /combos/new(.:format)                                            combos#new
#                         edit_combo GET    /combos/:id/edit(.:format)                                       combos#edit
#                              combo GET    /combos/:id(.:format)                                            combos#show
#                                    PUT    /combos/:id(.:format)                                            combos#update
#                                    DELETE /combos/:id(.:format)                                            combos#destroy
#             combos_agregar_detalle POST   /combos/agregar_detalle(.:format)                                combos#agregar_detalle
#                                    DELETE /combos/quitar_detalle/:id(.:format)                             combos#quitar_detalle
#                                    GET    /combos/copiar/:combo_id(.:format)                               combos#copiar
#                        proveedores GET    /proveedores(.:format)                                           proveedores#index
#                                    POST   /proveedores(.:format)                                           proveedores#create
#                      new_proveedor GET    /proveedores/new(.:format)                                       proveedores#new
#                     edit_proveedor GET    /proveedores/:id/edit(.:format)                                  proveedores#edit
#                          proveedor GET    /proveedores/:id(.:format)                                       proveedores#show
#                                    PUT    /proveedores/:id(.:format)                                       proveedores#update
#                                    DELETE /proveedores/:id(.:format)                                       proveedores#destroy
#                           entregas GET    /entregas(.:format)                                              entregas#index
#                                    POST   /entregas(.:format)                                              entregas#create
#                        new_entrega GET    /entregas/new(.:format)                                          entregas#new
#                       edit_entrega GET    /entregas/:id/edit(.:format)                                     entregas#edit
#                            entrega GET    /entregas/:id(.:format)                                          entregas#show
#                                    PUT    /entregas/:id(.:format)                                          entregas#update
#                                    DELETE /entregas/:id(.:format)                                          entregas#destroy
#                         parametros GET    /parametros(.:format)                                            parametros#index
#                                    POST   /parametros(.:format)                                            parametros#create
#                      new_parametro GET    /parametros/new(.:format)                                        parametros#new
#                     edit_parametro GET    /parametros/:id/edit(.:format)                                   parametros#edit
#                          parametro GET    /parametros/:id(.:format)                                        parametros#show
#                                    PUT    /parametros/:id(.:format)                                        parametros#update
#                                    DELETE /parametros/:id(.:format)                                        parametros#destroy
#                      carrito_items GET    /carrito_items(.:format)                                         carrito_items#index
#                                    POST   /carrito_items(.:format)                                         carrito_items#create
#                   new_carrito_item GET    /carrito_items/new(.:format)                                     carrito_items#new
#                  edit_carrito_item GET    /carrito_items/:id/edit(.:format)                                carrito_items#edit
#                       carrito_item GET    /carrito_items/:id(.:format)                                     carrito_items#show
#                                    PUT    /carrito_items/:id(.:format)                                     carrito_items#update
#                                    DELETE /carrito_items/:id(.:format)                                     carrito_items#destroy
#                           carritos GET    /carritos(.:format)                                              carritos#index
#                                    POST   /carritos(.:format)                                              carritos#create
#                        new_carrito GET    /carritos/new(.:format)                                          carritos#new
#                       edit_carrito GET    /carritos/:id/edit(.:format)                                     carritos#edit
#                            carrito GET    /carritos/:id(.:format)                                          carritos#show
#                                    PUT    /carritos/:id(.:format)                                          carritos#update
#                                    DELETE /carritos/:id(.:format)                                          carritos#destroy
#                              admin GET    /admin(.:format)                                                 admin#index
#                                    GET    /admin/domicilio_valido/:id(.:format)                            admin#validar_domicilio
#                                    GET    /admin/domicilio_invalido/:id(.:format)                          admin#invalidar_domicilio
#                                    GET    /admin/venta_entregada/:venta_id(.:format)                       admin#venta_entregada
#                                    GET    /admin/venta_cancelada/:venta_id(.:format)                       admin#venta_cancelada
#   admin_imprimir_proximas_entregas GET    /admin/imprimir_proximas_entregas(.:format)                      admin#imprimir_proximas_entregas
#                              login GET    /login(.:format)                                                 sessions#new
#                                    POST   /login(.:format)                                                 sessions#create
#                             logout DELETE /logout(.:format)                                                sessions#destroy
#                  login_or_register GET    /login_or_register(.:format)                                     sessions#login_or_register
#                           registro GET    /registro(.:format)                                              sessions#registro
#                        registrarme POST   /registrarme(.:format)                                           sessions#create_usuario
#             ventas_agregar_detalle        /ventas/agregar_detalle(.:format)                                ventas#agregar_detalle
#                                           /ventas/quitar_detalle/:id(.:format)                             ventas#quitar_detalle
#                             ventas GET    /ventas(.:format)                                                ventas#index
#                                    POST   /ventas(.:format)                                                ventas#create
#                          new_venta GET    /ventas/new(.:format)                                            ventas#new
#                         edit_venta GET    /ventas/:id/edit(.:format)                                       ventas#edit
#                              venta GET    /ventas/:id(.:format)                                            ventas#show
#                                    PUT    /ventas/:id(.:format)                                            ventas#update
#                                    DELETE /ventas/:id(.:format)                                            ventas#destroy
#                     venta_detalles GET    /venta_detalles(.:format)                                        venta_detalles#index
#                                    POST   /venta_detalles(.:format)                                        venta_detalles#create
#                  new_venta_detalle GET    /venta_detalles/new(.:format)                                    venta_detalles#new
#                 edit_venta_detalle GET    /venta_detalles/:id/edit(.:format)                               venta_detalles#edit
#                      venta_detalle GET    /venta_detalles/:id(.:format)                                    venta_detalles#show
#                                    PUT    /venta_detalles/:id(.:format)                                    venta_detalles#update
#                                    DELETE /venta_detalles/:id(.:format)                                    venta_detalles#destroy
#                                    GET    /cambiar_domicilio_entrega/:from/:to(.:format)                   ventas#cambiar_domicilio_entrega
#                                    GET    /confirmar_venta/:id(.:format)                                   ventas#confirmar
#            compras_agregar_detalle        /compras/agregar_detalle(.:format)                               compras#agregar_detalle
#                                           /compras/quitar_detalle/:id(.:format)                            compras#quitar_detalle
#                            compras GET    /compras(.:format)                                               compras#index
#                                    POST   /compras(.:format)                                               compras#create
#                         new_compra GET    /compras/new(.:format)                                           compras#new
#                        edit_compra GET    /compras/:id/edit(.:format)                                      compras#edit
#                             compra GET    /compras/:id(.:format)                                           compras#show
#                                    PUT    /compras/:id(.:format)                                           compras#update
#                                    DELETE /compras/:id(.:format)                                           compras#destroy
#                    compra_detalles GET    /compra_detalles(.:format)                                       compra_detalles#index
#                                    POST   /compra_detalles(.:format)                                       compra_detalles#create
#                 new_compra_detalle GET    /compra_detalles/new(.:format)                                   compra_detalles#new
#                edit_compra_detalle GET    /compra_detalles/:id/edit(.:format)                              compra_detalles#edit
#                     compra_detalle GET    /compra_detalles/:id(.:format)                                   compra_detalles#show
#                                    PUT    /compra_detalles/:id(.:format)                                   compra_detalles#update
#                                    DELETE /compra_detalles/:id(.:format)                                   compra_detalles#destroy
#                                           /productos/:id/categorias(.:format)                              productos#categorias
#        productos_agregar_categoria        /productos/agregar_categoria(.:format)                           productos#agregar_categoria
#                                           /productos/quitar_categoria/:id(.:format)                        productos#quitar_categoria
#                             marcas GET    /marcas(.:format)                                                marcas#index
#                                    POST   /marcas(.:format)                                                marcas#create
#                          new_marca GET    /marcas/new(.:format)                                            marcas#new
#                         edit_marca GET    /marcas/:id/edit(.:format)                                       marcas#edit
#                              marca GET    /marcas/:id(.:format)                                            marcas#show
#                                    PUT    /marcas/:id(.:format)                                            marcas#update
#                                    DELETE /marcas/:id(.:format)                                            marcas#destroy
#                   detalles_compras GET    /detalles_compras(.:format)                                      detalles_compras#index
#                                    POST   /detalles_compras(.:format)                                      detalles_compras#create
#                new_detalles_compra GET    /detalles_compras/new(.:format)                                  detalles_compras#new
#               edit_detalles_compra GET    /detalles_compras/:id/edit(.:format)                             detalles_compras#edit
#                    detalles_compra GET    /detalles_compras/:id(.:format)                                  detalles_compras#show
#                                    PUT    /detalles_compras/:id(.:format)                                  detalles_compras#update
#                                    DELETE /detalles_compras/:id(.:format)                                  detalles_compras#destroy
#                              hijos GET    /hijos(.:format)                                                 hijos#index
#                                    POST   /hijos(.:format)                                                 hijos#create
#                           new_hijo GET    /hijos/new(.:format)                                             hijos#new
#                          edit_hijo GET    /hijos/:id/edit(.:format)                                        hijos#edit
#                               hijo GET    /hijos/:id(.:format)                                             hijos#show
#                                    PUT    /hijos/:id(.:format)                                             hijos#update
#                                    DELETE /hijos/:id(.:format)                                             hijos#destroy
#                              vales GET    /vales(.:format)                                                 vales#index
#                                    POST   /vales(.:format)                                                 vales#create
#                           new_vale GET    /vales/new(.:format)                                             vales#new
#                          edit_vale GET    /vales/:id/edit(.:format)                                        vales#edit
#                               vale GET    /vales/:id(.:format)                                             vales#show
#                                    PUT    /vales/:id(.:format)                                             vales#update
#                                    DELETE /vales/:id(.:format)                                             vales#destroy
#                         domicilios GET    /domicilios(.:format)                                            domicilios#index
#                                    POST   /domicilios(.:format)                                            domicilios#create
#                      new_domicilio GET    /domicilios/new(.:format)                                        domicilios#new
#                     edit_domicilio GET    /domicilios/:id/edit(.:format)                                   domicilios#edit
#                          domicilio GET    /domicilios/:id(.:format)                                        domicilios#show
#                                    PUT    /domicilios/:id(.:format)                                        domicilios#update
#                                    DELETE /domicilios/:id(.:format)                                        domicilios#destroy
#                            barrios GET    /barrios(.:format)                                               barrios#index
#                                    POST   /barrios(.:format)                                               barrios#create
#                         new_barrio GET    /barrios/new(.:format)                                           barrios#new
#                        edit_barrio GET    /barrios/:id/edit(.:format)                                      barrios#edit
#                             barrio GET    /barrios/:id(.:format)                                           barrios#show
#                                    PUT    /barrios/:id(.:format)                                           barrios#update
#                                    DELETE /barrios/:id(.:format)                                           barrios#destroy
#                           usuarios GET    /usuarios(.:format)                                              usuarios#index
#                                    POST   /usuarios(.:format)                                              usuarios#create
#                        new_usuario GET    /usuarios/new(.:format)                                          usuarios#new
#                       edit_usuario GET    /usuarios/:id/edit(.:format)                                     usuarios#edit
#                            usuario GET    /usuarios/:id(.:format)                                          usuarios#show
#                                    PUT    /usuarios/:id(.:format)                                          usuarios#update
#                                    DELETE /usuarios/:id(.:format)                                          usuarios#destroy
#                          productos GET    /productos(.:format)                                             productos#index
#                                    POST   /productos(.:format)                                             productos#create
#                       new_producto GET    /productos/new(.:format)                                         productos#new
#                      edit_producto GET    /productos/:id/edit(.:format)                                    productos#edit
#                           producto GET    /productos/:id(.:format)                                         productos#show
#                                    PUT    /productos/:id(.:format)                                         productos#update
#                                    DELETE /productos/:id(.:format)                                         productos#destroy
#                                    GET    /productos/copiar/:producto_id(.:format)                         productos#copiar
#                             tienda        /                                                                tienda#index
#                                    GET    /productos_categoria/:codigo(.:format)                           tienda#productos_categoria
#                                    POST   /productos_categoria/:codigo(.:format)                           tienda#productos_categoria
#                                    GET    /detalle_producto/:codigo(.:format)                              tienda#detalle_producto
#                                    GET    /detalle_oferta/:combo_id(.:format)                              tienda#detalle_combo
#                           contacto GET    /contacto(.:format)                                              tienda#contacto
#                                    POST   /contacto(.:format)                                              tienda#contacto
# nueva_compra_seleccionar_domicilio GET    /nueva_compra/seleccionar_domicilio(.:format)                    tienda#seleccionar_domicilio
#                                    GET    /nueva_compra/entrega/:domicilio_id(.:format)                    tienda#entrega
#                                    GET    /nueva_compra/resumen/:domicilio_id/:entrega_id/:fecha(.:format) tienda#resumen
#                                    POST   /nueva_compra/resumen/:domicilio_id/:entrega_id/:fecha(.:format) tienda#resumen
#             nueva_compra_confirmar GET    /nueva_compra/confirmar(.:format)                                tienda#confirmar
#                    nuevo_domicilio POST   /nuevo_domicilio(.:format)                                       tienda#nuevo_dom
#                           busqueda POST   /busqueda(.:format)                                              tienda#busqueda
#                            alcance GET    /alcance(.:format)                                               tienda#alcance
#                           nosotros GET    /nosotros(.:format)                                              tienda#nosotros
#                            ofertas GET    /ofertas(.:format)                                               tienda#ofertas
#                                    POST   /ofertas(.:format)                                               tienda#ofertas
#                         destacados GET    /destacados(.:format)                                            tienda#destacados
#                                    POST   /destacados(.:format)                                            tienda#destacados
#                          servicios GET    /servicios(.:format)                                             tienda#servicios
#                          preguntas GET    /preguntas(.:format)                                             tienda#preguntas
#         mi_cuenta_datos_personales GET    /mi_cuenta/datos_personales(.:format)                            mi_cuenta#datos_personales
#                  mi_cuenta_pedidos GET    /mi_cuenta/pedidos(.:format)                                     mi_cuenta#pedidos
#                                    GET    /mi_cuenta/pedidos/:venta_id(.:format)                           mi_cuenta#pedido
#                    mi_cuenta_vales GET    /mi_cuenta/vales(.:format)                                       mi_cuenta#vales
#             mi_cuenta_cambio_clave GET    /mi_cuenta/cambio_clave(.:format)                                mi_cuenta#cambio_clave
#                                    POST   /mi_cuenta/cambio_clave(.:format)                                mi_cuenta#cambio_clave
#                mi_cuenta_hijos_new GET    /mi_cuenta/hijos/new(.:format)                                   mi_cuenta#new_hijo
#                                    GET    /mi_cuenta/hijos/:hijo_id(.:format)                              mi_cuenta#edit_hijo
#                    mi_cuenta_hijos POST   /mi_cuenta/hijos(.:format)                                       mi_cuenta#create_hijo
#                                    PUT    /mi_cuenta/hijos/:hijo_id(.:format)                              mi_cuenta#update_hijo
#               mi_cuenta_domicilios GET    /mi_cuenta/domicilios(.:format)                                  mi_cuenta#domicilios
#           mi_cuenta_domicilios_new GET    /mi_cuenta/domicilios/new(.:format)                              mi_cuenta#new_domicilio
#                                    POST   /mi_cuenta/domicilios(.:format)                                  mi_cuenta#create_domicilio
#                                    DELETE /mi_cuenta/domicilios/:dom_id(.:format)                          mi_cuenta#delete_domicilio
#                                    GET    /mi_cuenta/domicilios/:dom_id(.:format)                          mi_cuenta#edit_domicilio
#                                    PUT    /mi_cuenta/domicilios/:dom_id(.:format)                          mi_cuenta#update_domicilio
#                         categorias GET    /categorias(.:format)                                            categorias#index
#                                    POST   /categorias(.:format)                                            categorias#create
#                      new_categoria GET    /categorias/new(.:format)                                        categorias#new
#                     edit_categoria GET    /categorias/:id/edit(.:format)                                   categorias#edit
#                          categoria GET    /categorias/:id(.:format)                                        categorias#show
#                                    PUT    /categorias/:id(.:format)                                        categorias#update
#                                    DELETE /categorias/:id(.:format)                                        categorias#destroy
