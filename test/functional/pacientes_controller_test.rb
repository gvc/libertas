require 'test_helper'

class PacientesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pacientes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create paciente" do
    assert_difference('Paciente.count') do
      post :create, :paciente => { }
    end

    assert_redirected_to paciente_path(assigns(:paciente))
  end

  test "should show paciente" do
    get :show, :id => pacientes(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => pacientes(:one).to_param
    assert_response :success
  end

  test "should update paciente" do
    put :update, :id => pacientes(:one).to_param, :paciente => { }
    assert_redirected_to paciente_path(assigns(:paciente))
  end

  test "should destroy paciente" do
    assert_difference('Paciente.count', -1) do
      delete :destroy, :id => pacientes(:one).to_param
    end

    assert_redirected_to pacientes_path
  end
end
