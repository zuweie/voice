require 'test_helper'

class RekordsControllerTest < ActionController::TestCase
  setup do
    @rekord = rekords(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rekords)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rekord" do
    assert_difference('Rekord.count') do
      post :create, rekord: @rekord.attributes
    end

    assert_redirected_to rekord_path(assigns(:rekord))
  end

  test "should show rekord" do
    get :show, id: @rekord.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @rekord.to_param
    assert_response :success
  end

  test "should update rekord" do
    put :update, id: @rekord.to_param, rekord: @rekord.attributes
    assert_redirected_to rekord_path(assigns(:rekord))
  end

  test "should destroy rekord" do
    assert_difference('Rekord.count', -1) do
      delete :destroy, id: @rekord.to_param
    end

    assert_redirected_to rekords_path
  end
end
