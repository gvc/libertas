class Telefone < ActiveRecord::Base
  belongs_to :pessoa
  
  validates_presence_of :codigo_area, :message => 'indefinido.'
  validates_presence_of :telefone, :message => 'indefinido.'
end
