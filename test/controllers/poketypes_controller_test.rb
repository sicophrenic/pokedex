require 'test_helper'

class PoketypesControllerTest < ActionController::TestCase
  setup do
    @poketype = poketypes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:poketypes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create poketype" do
    assert_difference('Poketype.count') do
      post :create, poketype: {  }
    end

    assert_redirected_to poketype_path(assigns(:poketype))
  end

  test "should show poketype" do
    get :show, id: @poketype
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @poketype
    assert_response :success
  end

  test "should update poketype" do
    patch :update, id: @poketype, poketype: {  }
    assert_redirected_to poketype_path(assigns(:poketype))
  end

  test "should destroy poketype" do
    assert_difference('Poketype.count', -1) do
      delete :destroy, id: @poketype
    end

    assert_redirected_to poketypes_path
  end
end
