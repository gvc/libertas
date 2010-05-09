class Terapeuta < ActiveRecord::Base
  belongs_to :funcionario, :dependent => :destroy
  has_many :agendas_disponibilidade, :dependent => :destroy, :class_name => 'AgendaDisponibilidade', :order => 'dia_semana, hora_inicial'
  validates_presence_of :crp
  
  accepts_nested_attributes_for :funcionario
  accepts_nested_attributes_for :agendas_disponibilidade, :allow_destroy => true
end
