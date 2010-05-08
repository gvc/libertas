class Terapeuta < ActiveRecord::Base
  belongs_to :funcionario, :dependent => :destroy
  validates_presence_of :crp
  
  accepts_nested_attributes_for :funcionario
end
