class Consulta < ActiveRecord::Base
  belongs_to :paciente
  belongs_to :terapeuta
  
  validates_presence_of :terapeuta, :paciente
  validates_uniqueness_of :data_consulta, :scope => [:terapeuta_id], :message => 'já marcada. Escolha outro horário.'
  
  before_validation :setar_dia_hora
  
  validate :existe_disponibilidade?, :if => lambda { |c| c.data_valida? }
  
  attr_accessor :hora_consulta, :dia_consulta
  
  def self.horas_consulta
    [['08:00 - 09:00', '08:00'], ['09:00 - 10:00', '09:00'], ['10:00 - 11:00', '10:00'], ['11:00 - 12:00', '11:00'], ['12:00 - 13:00', '12:00'],
     ['13:00 - 14:00', '13:00'], ['14:00 - 15:00', '14:00'], ['15:00 - 16:00', '15:00'], ['16:00 - 17:00', '16:00'], ['17:00 - 18:00', '17:00']]
  end
  
  def setar_dia_hora
    self.data_consulta = DateTime.strptime("#{dia_consulta} #{hora_consulta}", "%d/%m/%Y %H:%M")
  rescue
  end
  
  def self.transformar_data(data)
    formato_data = /\d{2}\/\d{2}\/\d{4}/
    data_split = data.split(/\//)
    dataForm = "#{data_split[2]}-#{data_split[1]}-#{data_split[0]}"
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
  
  def dia_semana
    self.data_consulta.to_date.wday() - 1 if self.data_consulta
  end
  
  def data_valida?
    DateTime.strptime("#{dia_consulta} #{hora_consulta}", "%d/%m/%Y %H:%M")
    true
  rescue
    self.errors.add(:data_consulta, 'inválida.')
    false
  end
  
  def existe_disponibilidade?
    agendas = AgendaDisponibilidade.find(:all, :conditions => {:hora_inicial => self.data_consulta, :dia_semana => self.dia_semana, :terapeuta_id => self.terapeuta})
    
    if agendas.empty?
      errors.add_to_base('O terapeuta não atende no horário selecionado.') if errors.empty?
    end
  end
  
end
