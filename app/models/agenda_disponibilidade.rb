class AgendaDisponibilidade < ActiveRecord::Base
  belongs_to :terapeuta
  
  validates_inclusion_of :dia_semana, :in => (0..6).to_a
  validates_presence_of :hora_inicial
  
  def self.dias_semana
    [['Domingo', 0], ['Segunda', 1], ['Terça', 2], ['Quarta', 3], ['Quinta', 4], ['Sexta', 5], ['Sábado', 6]]
  end
end
