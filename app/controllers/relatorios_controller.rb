class RelatoriosController < ApplicationController
  def despesas
    processar_datas
    @despesas = Conta.despesas.all(:conditions => ['data_vencimento BETWEEN ? AND ?', @data_inicial, @data_final], :order => 'data_vencimento')
  end
  
  def receitas
    processar_datas
    @receitas = Conta.receitas.all(:conditions => ['data_vencimento BETWEEN ? AND ?', @data_inicial, @data_final], :order => 'data_vencimento')
  end
  
  def movimentacao_financeira
    processar_datas
    @contas = Conta.all(:conditions => ['data_vencimento BETWEEN ? AND ?', @data_inicial, @data_final], :order => 'data_vencimento')
  end

protected
  def processar_datas
    mes = (params[:date].try(:fetch, :month) || Date.today.month).to_i
    ano = (params[:date].try(:fetch, :year) || Date.today.year).to_i
    
    @data_inicial = Date.new(ano, mes, 1)
    @data_final = @data_inicial.at_end_of_month
  end
end
