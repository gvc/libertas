class Endereco < ActiveRecord::Base
  belongs_to :pessoa
  
  validates_presence_of :rua, :message => 'indefinida.'
  validates_presence_of :bairro, :message => 'indefinido.'
  validates_presence_of :cidade, :message => 'indefinida.'
  validates_presence_of :estado, :message => 'indefinido.'
  
    
  def lista_estados
       
        {'Centro-Oeste' => [
            ['Distrito Federal', 'Distrito Federal'],
            ['Goiás', 'Goiás'],
            ['Mato Grosso', 'Mato Grosso'],
            ['Mato Grosso do Sul', 'Mato Grosso do Sul'],
            ['Tocantins', 'Tocantins']],
        'Nordeste' => [
            ['Alagoas', 'Alagoas'],
            ['Bahia', 'Bahia'],
            ['Ceará', 'Ceará'],
            ['Maranhão', 'Maranhão'],
            ['Paraíba', 'Paraíba'],
            ['Pernambuco', 'Pernambuco'],
            ['Piauí', 'Piauí'],
            ['Rio Grande do Norte', 'Rio Grande do Norte'],
            ['Sergipe', 'Sergipe']],
        'Norte' => [
            ['Acre', 'Acre'],
            ['Amapá', 'Amapá'],
            ['Amazonas', 'Amazonas'],
            ['Pará', 'Pará'],
            ['Rondônia', 'Rondônia'],
            ['Roraima', 'Roraima']],
        'Sudeste' => [
            ['Espírito Santo', 'Espírito Santo'],
            ['Minas Gerais', 'Minas Gerais'],
            ['Rio de Janeiro', 'Rio de Janeiro'],
            ['São Paulo', 'São Paulo']],
        'Sul' => [
            ['Paraná', 'Paraná'],
            ['Rio Grande do Sul', 'Rio Grande do Sul'],
            ['Santa Catarina', 'Santa Catarina']]}
        
      
    end
end
