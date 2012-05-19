require 'test_helper'

class VentaDetallesControllerTest < ActionController::TestCase
  setup do
    @venta_detalle = venta_detalles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:venta_detalles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create venta_detalle" do
    assert_difference('VentaDetalle.count') do
      post :create, venta_detalle: @venta_detalle.attributes
    end

    assert_redirected_to venta_detalle_path(assigns(:venta_detalle))
  end

  test "should show venta_detalle" do
    get :show, id: @venta_detalle
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @venta_detalle
    assert_response :success
  end

  test "should update venta_detalle" do
    put :update, id: @venta_detalle, venta_detalle: @venta_detalle.attributes
    assert_redirected_to venta_detalle_path(assigns(:venta_detalle))
  end

  test "should destroy venta_detalle" do
    assert_difference('VentaDetalle.count', -1) do
      delete :destroy, id: @venta_detalle
    end

    assert_redirected_to venta_detalles_path
  end
end
