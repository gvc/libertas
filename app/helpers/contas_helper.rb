module ContasHelper
  
  def formatar_data(data)
    partes = data.to_s.split /-/
    [partes[2], partes[1], partes[0]].join '/'
  end
  
end
