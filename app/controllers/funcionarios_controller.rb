class FuncionariosController < ApplicationController
  before_filter :autenticar
  
  # GET /funcionarios
  def index
    @funcionarios = Funcionario.all
  end

  # GET /funcionarios/1
  def show
    @funcionario = Funcionario.find(params[:id])
  end

  # GET /funcionarios/new
  def new
    @funcionario = Funcionario.new
    @funcionario.build_pessoa
    @funcionario.pessoa.build_endereco
  end

  # GET /funcionarios/1/edit
  def edit
    @funcionario = Funcionario.find(params[:id])
  end

  # POST /funcionarios
  def create
    @funcionario = Funcionario.new(params[:funcionario])
    
    if @funcionario.save
      flash[:notice] = 'Funcionário criado com sucesso.'
      redirect_to(@funcionario)
    else
      render :action => :new
    end
  end

  # PUT /funcionarios/1
  def update
    @funcionario = Funcionario.find(params[:id])
    if @funcionario.update_attributes(params[:funcionario])
      flash[:notice] = 'Funcionário atualizado com sucesso.'
      redirect_to(@funcionario)
    else
      render :action => "edit"
    end
  end

  # DELETE /funcionarios/1
  def destroy
    @funcionario = Funcionario.find(params[:id])
    @funcionario.destroy
    flash[:notice] = 'Funcionário removido com sucesso.'
    redirect_to(funcionarios_url)
  end
  
protected
  def autenticar
    unless Pessoa.funcionario?(session[:user])
      flash[:erro] = 'Você não pode acessar a listagem de pacientes.'
      redirect_to '/'
    end
  end
end
