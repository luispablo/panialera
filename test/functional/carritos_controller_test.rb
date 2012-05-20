require 'test_helper'

class CarritosControllerTest < ActionController::TestCase
  setup do
    @carrito = carritos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:carritos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create carrito" do
    assert_difference('Carrito.count') do
      post :create, carrito: @carrito.attributes
    end

    assert_redirected_to carrito_path(assigns(:carrito))
  end

  test "should show carrito" do
    get :show, id: @carrito
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @carrito
    assert_response :success
  end

  test "should update carrito" do
    put :update, id: @carrito, carrito: @carrito.attributes
    assert_redirected_to carrito_path(assigns(:carrito))
  end

  test "should destroy carrito" do
    assert_difference('Carrito.count', -1) do
      delete :destroy, id: @carrito
    end

    assert_redirected_to carritos_path
  end
end
