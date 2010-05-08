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
  validates_presence_of :senha, :message => 'indefinida.'
  
  validates_uniqueness_of :cpf, :message => 'já cadastrado no sistema.', :allow_blank => false
  
  validates_confirmation_of :senha, :message => 'deve ser igual à senha!', :on => :create
end
