class Conta < ActiveRecord::Base
  attr_accessible :descricao, :valor, :tipo_conta
  
  validates_presence_of :descricao, :valor, :tipo_conta, :data_vencimento, :data_pagamento  
  validates_inclusion_of :tipo_conta, :in => %w{R D}

  def transformar_datas(data_pagamento, data_vencimento)
    formato_data = /\d{2}\/\d{2}\/\d{4}/
    if data_pagamento =~ formato_data
      pagamento = data_pagamento.split(/\//)
      self.data_pagamento = "#{pagamento[1]}/#{pagamento[0]}/#{pagamento[2]}".to_date
      puts self.data_vencimento
    else
      self.errors.add(:data_pagamento, 'is invalid')
    end
    
    if data_vencimento =~ formato_data 
      vencimento = data_vencimento.split(/\//)
      self.data_vencimento = "#{vencimento[1]}/#{vencimento[0]}/#{vencimento[2]}".to_date
      puts self.data_vencimento
    else
      self.errors.add(:data_vencimento, 'is invalid')
    end
  end
end
