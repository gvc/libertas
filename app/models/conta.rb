class Conta < ActiveRecord::Base
  attr_accessible :descricao, :valor, :tipo_conta
  
  validates_presence_of :descricao, :valor, :tipo_conta  
  validates_inclusion_of :tipo_conta, :in => %w{R D}

  def transformar_datas(data_pagamento, data_vencimento)
    formato_data = /\d{2}\/\d{2}\/\d{4}/
    if data_pagamento != nil && data_pagamento != ''

      if data_pagamento =~ formato_data
        pagamento = data_pagamento.split(/\//)
        if validar_data(pagamento)
          self.data_pagamento = "#{pagamento[1]}/#{pagamento[0]}/#{pagamento[2]}".to_date
          puts self.data_pagamento
        else
          self.errors.add(:data_pagamento, 'é inválida')
          return false
        end
      else
        self.errors.add(:data_pagamento, 'é inválida')
        return false
      end
    else
      self.data_pagamento = nil
    end

    if data_vencimento != nil && data_vencimento != ''
      if data_vencimento =~ formato_data 
        vencimento = data_vencimento.split(/\//)
        if validar_data(vencimento)
          self.data_vencimento = "#{vencimento[1]}/#{vencimento[0]}/#{vencimento[2]}".to_date
          puts self.data_vencimento
        else
          self.errors.add(:data_vencimento, 'é inválida')
          return false
        end
      else
        self.errors.add(:data_vencimento, 'é inválida')
        return false
      end
    else
      self.data_vencimento = nil
    end

    return true
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
  
  
end
