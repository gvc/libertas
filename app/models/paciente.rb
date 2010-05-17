class Paciente < ActiveRecord::Base
  belongs_to :pessoa, :dependent => :destroy
  has_many :consultas, :dependent => :destroy
  accepts_nested_attributes_for :pessoa
  
  def cpf_nome
    self.pessoa.cpf + ' - ' + self.pessoa.nome
  end
end
