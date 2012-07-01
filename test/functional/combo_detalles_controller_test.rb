require 'test_helper'

class ComboDetallesControllerTest < ActionController::TestCase
  setup do
    @combo_detalle = combo_detalles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:combo_detalles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create combo_detalle" do
    assert_difference('ComboDetalle.count') do
      post :create, combo_detalle: @combo_detalle.attributes
    end

    assert_redirected_to combo_detalle_path(assigns(:combo_detalle))
  end

  test "should show combo_detalle" do
    get :show, id: @combo_detalle
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @combo_detalle
    assert_response :success
  end

  test "should update combo_detalle" do
    put :update, id: @combo_detalle, combo_detalle: @combo_detalle.attributes
    assert_redirected_to combo_detalle_path(assigns(:combo_detalle))
  end

  test "should destroy combo_detalle" do
    assert_difference('ComboDetalle.count', -1) do
      delete :destroy, id: @combo_detalle
    end

    assert_redirected_to combo_detalles_path
  end
end
