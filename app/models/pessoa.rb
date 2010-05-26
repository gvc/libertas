require 'digest/sha1'

class Pessoa < ActiveRecord::Base
  belongs_to :paciente
  has_one :endereco, :dependent => :destroy
  has_many :telefones, :dependent => :destroy
  
  accepts_nested_attributes_for :endereco, :telefones
  
  attr_accessor :senha_confirmation
  
  validates_presence_of :nome, :message => 'indefinido.'
  validates_presence_of :sexo, :message => 'indefinido.'
  validates_inclusion_of :sexo, :in => %w{M F}
  validates_presence_of :data_nascimento, :message => 'indefinida.'
  validates_presence_of :email, :message => 'indefinido.'
  validates_presence_of :username, :message => 'indefinido.'
  validates_presence_of :senha, :message => 'indefinida.', :on => :create
  
  validates_uniqueness_of :cpf, :message => 'já cadastrado no sistema.', :allow_blank => false
  
  validates_confirmation_of :senha, :message => 'deve ser igual à senha!', :on => :create
  
  validate :validar_cpf
  
  # def transformar_data(data_nascimento)
  #   formato_data = /\d{2}\/\d{2}\/\d{4}/
  #   if data_nascimento =~ formato_data
  #     nascimento = data_nascimento.split(/\//)
  #     if validar_data(nascimento)
  #       self.data_nascimento = "#{nascimento[1]}/#{nascimento[0]}/#{nascimento[2]}".to_date
  #       puts("Data de Nascimento Formatada: #{self.data_nascimento}")
  #     else
  #       self.errors.add(:data_nascimento, 'é inválida!')
  #       return false
  #     end
  #   else
  #     self.errors.add(:data_nascimento, 'é inválida!')
  #     return false
  #   end
  #   return true
  # end
  
  # def eh_bisexto(ano)
  #   if (ano % 4) == 0 && ((ano % 400 == 0) || (ano % 100 != 0))
  #     return true
  #   end
  #     return false
  # end
  
  def senha
    @senha    
  end
  
  def senha=(valor)
    @senha = valor
    return if valor.blank?
    criar_sal
    self['senha_hash'] = Pessoa.senha_criptografada(valor, self.sal)
  end
  
  def criar_sal
    self.sal = self.object_id.to_s + rand.to_s
  end
  
  # def validar_data(data)
  #   dia = data[0].to_i
  #   mes = data[1].to_i
  #   ano = data[2].to_i
  #   
  #   meses_30 = [4,6,9,11]
  #   meses_31 = [1,3,5,7,8,12]
  #   fev_max = 28
  #   
  #   if mes > 12 || mes  < 1
  #     return false
  #   else
  #     if eh_bisexto(ano)
  #       fev_max = 29
  #     end
  #     
  #     if meses_30.include?(mes)
  #       if dia < 1 || dia > 30
  #         return false
  #       end
  #     elsif meses_31.include?(mes)
  #       if dia < 1 || dia > 31
  #         return false
  #       end
  #     else 
  #       if dia < 1 || dia > fev_max
  #         return false
  #       end
  #     end
  #   end      
  #   
  #   return true
  # end
  
  def self.senha_criptografada(senha, sal)
    string_to_hash = senha + "swing" + sal
    Digest::SHA1.hexdigest(string_to_hash)
  end
  
  def self.autenticar(login, senha)
    pessoa = self.find_by_username(login)
    if pessoa
      senha_esperada = senha_criptografada(senha, pessoa.sal)
      if pessoa.senha_hash != senha_esperada
        pessoa = nil
      end
    end
    
    pessoa
  end
  
  def validar_cpf
    value = self.cpf
    value.gsub!(/[^0-9]/, '')
    controle = ""
    digito   = value.slice(-2, 2)
    if value.size == 11 
      fator = 0
      2.times do |i|
        soma   = 0
        9.times do |j|
          soma += value.slice(j, 1).to_i * (10 + i - j)
        end
        soma += (fator * 2) if i == 1
        fator = (soma * 10) % 11
        fator = 0 if ( fator == 10 )
        controle << fator.to_s
      end 
    end 
    unless controle == digito
      errors.add(:cpf, 'é inválido.')
    end
  end

  def self.funcionario?(usuario)
    Funcionario.find_by_pessoa_id(usuario.id)
  end
  
  def self.administrador?(usuario)
    funcionario = funcionario?(usuario)
    funcionario.admin? if funcionario    
  end
end
