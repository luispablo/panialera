require 'test_helper'

class CarritoItemsControllerTest < ActionController::TestCase
  setup do
    @carrito_item = carrito_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:carrito_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create carrito_item" do
    assert_difference('CarritoItem.count') do
      post :create, carrito_item: @carrito_item.attributes
    end

    assert_redirected_to carrito_item_path(assigns(:carrito_item))
  end

  test "should show carrito_item" do
    get :show, id: @carrito_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @carrito_item
    assert_response :success
  end

  test "should update carrito_item" do
    put :update, id: @carrito_item, carrito_item: @carrito_item.attributes
    assert_redirected_to carrito_item_path(assigns(:carrito_item))
  end

  test "should destroy carrito_item" do
    assert_difference('CarritoItem.count', -1) do
      delete :destroy, id: @carrito_item
    end

    assert_redirected_to carrito_items_path
  end
end
