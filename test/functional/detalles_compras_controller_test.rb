require 'test_helper'

class DetallesComprasControllerTest < ActionController::TestCase
  setup do
    @detalle_compra = detalles_compras(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:detalles_compras)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create detalle_compra" do
    assert_difference('DetalleCompra.count') do
      post :create, detalle_compra: @detalle_compra.attributes
    end

    assert_redirected_to detalle_compra_path(assigns(:detalle_compra))
  end

  test "should show detalle_compra" do
    get :show, id: @detalle_compra
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @detalle_compra
    assert_response :success
  end

  test "should update detalle_compra" do
    put :update, id: @detalle_compra, detalle_compra: @detalle_compra.attributes
    assert_redirected_to detalle_compra_path(assigns(:detalle_compra))
  end

  test "should destroy detalle_compra" do
    assert_difference('DetalleCompra.count', -1) do
      delete :destroy, id: @detalle_compra
    end

    assert_redirected_to detalles_compras_path
  end
end
