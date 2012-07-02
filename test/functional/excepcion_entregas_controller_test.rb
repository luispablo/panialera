require 'test_helper'

class ExcepcionEntregasControllerTest < ActionController::TestCase
  setup do
    @excepcion_entrega = excepcion_entregas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:excepcion_entregas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create excepcion_entrega" do
    assert_difference('ExcepcionEntrega.count') do
      post :create, excepcion_entrega: @excepcion_entrega.attributes
    end

    assert_redirected_to excepcion_entrega_path(assigns(:excepcion_entrega))
  end

  test "should show excepcion_entrega" do
    get :show, id: @excepcion_entrega
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @excepcion_entrega
    assert_response :success
  end

  test "should update excepcion_entrega" do
    put :update, id: @excepcion_entrega, excepcion_entrega: @excepcion_entrega.attributes
    assert_redirected_to excepcion_entrega_path(assigns(:excepcion_entrega))
  end

  test "should destroy excepcion_entrega" do
    assert_difference('ExcepcionEntrega.count', -1) do
      delete :destroy, id: @excepcion_entrega
    end

    assert_redirected_to excepcion_entregas_path
  end
end
