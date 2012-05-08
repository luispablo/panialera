require 'test_helper'

class HijosControllerTest < ActionController::TestCase
  setup do
    @hijo = hijos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hijos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create hijo" do
    assert_difference('Hijo.count') do
      post :create, hijo: @hijo.attributes
    end

    assert_redirected_to hijo_path(assigns(:hijo))
  end

  test "should show hijo" do
    get :show, id: @hijo
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @hijo
    assert_response :success
  end

  test "should update hijo" do
    put :update, id: @hijo, hijo: @hijo.attributes
    assert_redirected_to hijo_path(assigns(:hijo))
  end

  test "should destroy hijo" do
    assert_difference('Hijo.count', -1) do
      delete :destroy, id: @hijo
    end

    assert_redirected_to hijos_path
  end
end
