require 'test_helper'

class FuncionarioTest < ActiveSupport::TestCase
  test "deve responder aos métodos de pessoa" do
    @funcionario = Funcionario.new
    
    @funcionario.nome = 'Joao da Silva'
    assert_equal 'Joao da Silva', @funcionario.nome
    
    assert_not_nil @funcionario.pessoa
  end
  
  # test "deve ser inválido quando o pessoa for inválido" do
  #   @funcionario = Funcionario.new
  # 
  #   assert !@funcionario.valid?
  #   
  #   @funcionario.rg = '1234'
  #   assert !@funcionario.valid? 
  # end
  # 
  # test "deve ser válido quando pessoa for válido" do
  #   @funcionario = Funcionario.new
  #   @funcionario.rg = '1234'
  #   @funcionario.nome = 'Jose da Silva'
  #   assert @funcionario.valid?
  # end
end
