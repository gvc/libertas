class Funcionario < ActiveRecord::Base
  belongs_to :pessoa, :dependent => :destroy
  validates_presence_of :rg
  
  accepts_nested_attributes_for :pessoa
end
