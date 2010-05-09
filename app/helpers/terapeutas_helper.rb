module TerapeutasHelper
  def formatar_dia_semana(dia)
    AgendaDisponibilidade.dias_semana.rassoc(dia).first
  end
  
  def formatar_hora_inicial(hora)
    hora.try(:strftime, '%H:%M')
  end
end
