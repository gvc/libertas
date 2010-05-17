class Consulta < ActiveRecord::Base
  belongs_to :paciente
  belongs_to :terapeuta
  
  validates_uniqueness_of :data_consulta, :scope => [:terapeuta_id]
  
  attr_accessor :hora_consulta, :dia_consulta
  
  def self.horas_consulta
    [['08:00 - 09:00', '08:00'], ['09:00 - 10:00', '09:00'], ['10:00 - 11:00', '10:00'], ['11:00 - 12:00', '11:00'], ['12:00 - 13:00', '12:00'],
     ['13:00 - 14:00', '13:00'], ['14:00 - 15:00', '14:00'], ['15:00 - 16:00', '15:00'], ['16:00 - 17:00', '16:00'], ['17:00 - 18:00', '17:00']]
  end
  
  def descricao
    descricao = 'Paciente: ' + self.paciente.pessoa.nome + ' - Data/Hora: ' + 
                Consulta.formatar_data_consulta(self.data_consulta) + ' - ' + Consulta.formatar_hora_consulta(self.data_consulta)
  end
  
  def self.formatar_hora_consulta(datetime)
    hora = datetime.to_time.try(:strftime, '%H:%M') if datetime
  end
  
  def self.formatar_data_consulta(datetime)
    data = datetime.to_date
    partes = data.to_s.split /-/
    data_formatada = [partes[2], partes[1], partes[0]].join '/'
  end
  
  def formatar_data_hora_consulta(hora,dia)
    self.data_consulta = (Consulta.transformar_data(dia) + ' ' + hora).to_datetime
  end
  
  def self.transformar_data(data)
    formato_data = /\d{2}\/\d{2}\/\d{4}/
    data_split = data.split(/\//)
    dataForm = "#{data_split[2]}-#{data_split[1]}-#{data_split[0]}"
   end
  
  def eh_bisexto(ano)
    if (ano % 4) == 0 && ((ano % 400 == 0) || (ano % 100 != 0))
      return true
    end
      return false
  end
  
  def validar_data(data)
    dia = data[0].to_i
    mes = data[1].to_i
    ano = data[2].to_i
    
    meses_30 = [4,6,9,11]
    meses_31 = [1,3,5,7,8,12]
    fev_max = 28
    
    if mes > 12 || mes  < 1
      return false
    else
      if eh_bisexto(ano)
        fev_max = 29
      end
      
      if meses_30.include?(mes)
        if dia < 1 || dia > 30
          return false
        end
      elsif meses_31.include?(mes)
        if dia < 1 || dia > 31
          return false
        end
      else 
        if dia < 1 || dia > fev_max
          return false
        end
      end
    end      
    
    return true
  end
  
  def self.data_segunda_feira(data_hoje)
    data = data_hoje
    datas = []
    if data.wday() != 6 && data.wday() != 0
      while data.wday() != 1
        data = data - 1;
      end
    else
      while data.wday() != 1
        data = data + 1;
      end
    end
    
    5.times do |i|
      datas[i] = Consulta.formatar_data_simples(data)
      data = data + 1
    end
        
    return datas
  end
  
  def self.formatar_data_simples(data)
    data_str = data.to_s
    partes = data_str.split /-/
    data_formatada = [partes[2], partes[1], partes[0]].join '/'
    return data_formatada
  end
  
  def self.verificar_disponibilidade(hora, dia_semana, terapeuta_id)
    hora_agenda = "2000-01-01  #{hora}".to_datetime
    agendas = AgendaDisponibilidade.find(:all, :conditions => {:hora_inicial => hora_agenda, :dia_semana => dia_semana, :terapeuta_id => terapeuta_id})
    
    if(agendas.empty?)
       #self.errors.add(:terapeuta_id, 'is invalid')
       return false
    end
    
    return true
    
  end
  
end
