class AgendaDisponibilidade < ActiveRecord::Base
  belongs_to :terapeuta
  
  validates_inclusion_of :dia_semana, :in => (0..6).to_a
  validates_presence_of :hora_inicial
  
  def self.dias_semana
    [['Segunda', 0], ['Terça', 1], ['Quarta', 2], ['Quinta', 3], ['Sexta', 4]]
  end
end
