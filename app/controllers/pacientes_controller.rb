class PacientesController < ApplicationController
  # GET /pacientes
  # GET /pacientes.xml
  def index
    @pacientes = Paciente.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pacientes }
    end
  end

  # GET /pacientes/1
  # GET /pacientes/1.xml
  def show
    @paciente = Paciente.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @paciente }
    end
  end

  # GET /pacientes/new
  # GET /pacientes/new.xml
  def new
    @paciente = Paciente.new
    @paciente.pessoa = Pessoa.new
    @paciente.pessoa.endereco = Endereco.new
    2.times {@paciente.pessoa.telefones.build}
    @descricao = 'Telefone*'
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @paciente }
    end
  end

  # GET /pacientes/1/edit
  def edit
    @paciente = Paciente.find(params[:id])
  end

  # POST /pacientes
  # POST /pacientes.xml
  def create
    @paciente = Paciente.new(params[:paciente])
    data_valida = @paciente.pessoa.transformar_data params[:paciente][:pessoa_attributes][:data_nascimento]
    senha_valida = @paciente.pessoa.validar_senha params[:paciente][:pessoa_attributes][:senha], params[:paciente][:pessoa_attributes][:conf_senha]
    @paciente.pessoa.telefones[0].is_celular = false
    @paciente.pessoa.telefones[1].is_celular = true
    @paciente.pessoa.endereco.estado = params[:estado]
    
    
    respond_to do |format|
      if data_valida && senha_valida && @paciente.save
        flash[:notice] = 'Paciente cadastrado com sucesso.'
        format.html { redirect_to(@paciente) }
        format.xml  { render :xml => @paciente, :status => :created, :location => @paciente }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @paciente.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pacientes/1
  # PUT /pacientes/1.xml
  def update
    @paciente = Paciente.find(params[:id])
    data_valida = @paciente.pessoa.transformar_data params[:paciente][:pessoa_attributes][:data_nascimento]

    respond_to do |format|
      if data_valida && senha_valida && @paciente.update_attributes(params[:paciente])
        flash[:notice] = 'Paciente atualizado com sucesso.'
        format.html { redirect_to(@paciente) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @paciente.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pacientes/1
  # DELETE /pacientes/1.xml
  def destroy
    @paciente = Paciente.find(params[:id])
    @paciente.destroy
    flash[:notice] = 'Paciente removido com sucesso.'
    respond_to do |format|
      format.html { redirect_to(pacientes_url) }
      format.xml  { head :ok }
    end
  end
end
