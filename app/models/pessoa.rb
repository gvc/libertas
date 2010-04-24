class Pessoa < ActiveRecord::Base
  has_one :paciente
  has_one :endereco, :dependent => :destroy
  has_many :telefones, :dependent => :destroy
  
  accepts_nested_attributes_for :endereco, :telefones
  
  attr_accessor :conf_senha
  
  validates_presence_of :nome, :message => 'indefinido.'
  validates_presence_of :sexo, :message => 'indefinido.'
  validates_inclusion_of :sexo, :in => %w{M F}
  validates_presence_of :data_nascimento, :message => 'indefinida.'
  validates_presence_of :email, :message => 'indefinido.'
  validates_presence_of :login, :message => 'indefinido.'
  validates_presence_of :senha, :message => 'indefinida.'
  
  validates_uniqueness_of :cpf, :message => 'já cadastrado no sistema.'
  
  
  def transformar_data(data_nascimento)
    formato_data = /\d{2}\/\d{2}\/\d{4}/
    if data_nascimento =~ formato_data
      nascimento = data_nascimento.split(/\//)
      if validar_data(nascimento)
        self.data_nascimento = "#{nascimento[1]}/#{nascimento[0]}/#{nascimento[2]}".to_date
        puts("Data de Nascimento Formatada: #{self.data_nascimento}")
      else
        self.errors.add(:data_nascimento, 'é inválida!')
        return false
      end
    else
      self.errors.add(:data_nascimento, 'é inválida!')
      return false
    end
    return true
  end
  
  def eh_bisexto(ano)
    if (ano % 4) == 0 && ((ano % 400 == 0) || (ano % 100 != 0))
      return true
    end
      return false
  end
  
  def validar_data(data)
    dia = data[0].to_i
    mes = data[1].to_i
    ano = data[2].to_i
    
    meses_30 = [4,6,9,11]
    meses_31 = [1,3,5,7,8,12]
    fev_max = 28
    
    if mes > 12 || mes  < 1
      return false
    else
      if eh_bisexto(ano)
        fev_max = 29
      end
      
      if meses_30.include?(mes)
        if dia < 1 || dia > 30
          return false
        end
      elsif meses_31.include?(mes)
        if dia < 1 || dia > 31
          return false
        end
      else 
        if dia < 1 || dia > fev_max
          return false
        end
      end
    end      
    
    return true
  end
  
  def validar_senha(senha, conf_senha)
      if senha != conf_senha
        self.errors.add(:conf_senha, 'Senhas Diferentes!')
        return false
      end
      return true
  end
end
