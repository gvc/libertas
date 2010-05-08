require 'test_helper'

class TerapeutaTest < ActiveSupport::TestCase
  test "deve responder aos métodos de funcionario" do
    @terapeuta = Terapeuta.new
    
    @terapeuta.rg = '123456'
    assert_equal '123456', @terapeuta.rg
    
    assert_not_nil @terapeuta.funcionario
  end
  
  test "deve ser inválido quando o funcionário for inválido" do
    @terapeuta = Terapeuta.new

    assert !@terapeuta.valid?
    
    @terapeuta.crp = '1234'
    assert !@terapeuta.valid? 
  end
  
  test "deve ser válido quando funcionário for válido" do
    @terapeuta = Terapeuta.new
    @terapeuta.crp = '1234'
    @terapeuta.rg = '1234'
    assert @terapeuta.valid?
  end
end
