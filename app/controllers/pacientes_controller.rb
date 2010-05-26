class PacientesController < ApplicationController
  before_filter :autenticar
  
  # GET /pacientes
  def index
    @pacientes = Paciente.all
  end

  # GET /pacientes/1
  def show
    @paciente = Paciente.find(params[:id])
  end

  # GET /pacientes/new
  def new
    @paciente = Paciente.new
    @paciente.build_pessoa
    @paciente.pessoa.build_endereco
    2.times { @paciente.pessoa.telefones.build }
    @descricao = 'Telefone*'
  end

  # GET /pacientes/1/edit
  def edit
    @paciente = Paciente.find(params[:id])
  end

  # POST /pacientes
  def create
    @paciente = Paciente.new(params[:paciente])
    @paciente.pessoa.telefones[0].celular = false
    @paciente.pessoa.telefones[1].celular = true
    
    if @paciente.save
      flash[:notice] = 'Paciente criado com sucesso.'
      redirect_to(@paciente)
    else
      render :action => :new
    end
  end

  # PUT /pacientes/1
  def update
    @paciente = Paciente.find(params[:id])
    if @paciente.update_attributes(params[:paciente])
      flash[:notice] = 'Paciente atualizado com sucesso.'
      redirect_to(@paciente)
    else
      render :action => "edit"
    end
  end

  # DELETE /pacientes/1
  def destroy
    @paciente = Paciente.find(params[:id])
    @paciente.destroy
    flash[:notice] = 'Paciente removido com sucesso.'
    redirect_to(pacientes_url)
  end
  
protected
  def autenticar
    unless Pessoa.funcionario?(session[:user])
      flash[:erro] = 'Você não pode acessar a listagem de pacientes.'
      redirect_to '/'
    end
  end
end
