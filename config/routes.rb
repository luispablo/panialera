Panialera::Application.routes.draw do

  resources :excepcion_entregas

  resources :combo_detalles

  resources :combos

  controller :combos do
    post '/combos/agregar_detalle' => :agregar_detalle
    delete '/combos/quitar_detalle/:id' => :quitar_detalle
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
  
  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root to: 'tienda#index', as: 'tienda'

  controller :tienda do
    get 'productos_categoria/:codigo' => :productos_categoria
    post 'productos_categoria/:codigo' => :productos_categoria
    get 'detalle_producto/:codigo' => :detalle_producto
    get 'contacto' => :contacto
    post 'contacto' => :contacto
    get 'nueva_compra/seleccionar_domicilio' => :seleccionar_domicilio
    get 'nueva_compra/entrega/:domicilio_id' => :entrega
    post 'nueva_compra/resumen' => :resumen
    get 'nueva_compra/confirmar' => :confirmar
    post 'busqueda' => :busqueda
    get 'alcance' => :alcance
    get 'ofertas' => :ofertas
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
