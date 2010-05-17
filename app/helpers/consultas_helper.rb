module ConsultasHelper
  
  def status_calendario(data, hora, dia_semana, terapeuta_id)
    status = ''
    data_split = data.split(/\//)
    data_hora = "#{data_split[2]}-#{data_split[1]}-#{data_split[0]}  #{hora}".to_datetime
    hora_agenda = "2000-01-01  #{hora}".to_datetime
        
    agendas = AgendaDisponibilidade.find(:all, :conditions => {:hora_inicial => hora_agenda, :dia_semana => dia_semana, :terapeuta_id => terapeuta_id})
    consultas = Consulta.find(:all, :conditions => {:data_consulta => data_hora, :terapeuta_id => terapeuta_id})
    
    if agendas.empty?
      status = 'indisponivel'
    else
      if consultas.empty?
        status = 'livre'
      else
        status = 'ocupado'
      end
    end
        
  end
    
end
