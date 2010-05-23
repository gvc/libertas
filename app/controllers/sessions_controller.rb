class SessionsController < ApplicationController
  
  def index
  end
  
  def create
    pessoa = Pessoa.autenticar(params[:login], params[:senha])
    if pessoa
      session[:user] = pessoa
      redirect_to consultas_path
    else
      flash[:erro] = 'Combinação login/senha errada'
      redirect_to :action => :index
    end
  end
  
  def destroy
    session[:user] = nil
    flash[:deslogado] = 'Você foi deslogado com sucesso'
    redirect_to :action => :index
  end
end
