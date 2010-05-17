class ConsultasController < ApplicationController
  
  $datas
  $terapeuta_selecionado
  
  # GET /consultas
  # GET /consultas.xml
  def index
    @consultas = Consulta.find(:all, :include => [{:paciente => :pessoa}], :order => "data_consulta DESC, pessoas.nome ASC")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @consultas }
    end
  end

  # GET /consultas/1
  # GET /consultas/1.xml
  def show
    @consulta = Consulta.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @consulta }
    end
  end

  # GET /consultas/new
  # GET /consultas/new.xml
  def new
    @consulta = Consulta.new
    @terapeutas = Terapeuta.all
    @pacientes = Paciente.all
    
    if params[:pd] == nil
      $datas = Consulta.data_segunda_feira(Date.today)
    else
      $datas = Consulta.data_segunda_feira(Consulta.transformar_data(params[:pd]).to_date)
    end
    
    if params[:ts] == nil
      $terapeuta_selecionado = 1
    else
      $terapeuta_selecionado = params[:ts]
    end
    
  end

  # GET /consultas/1/edit
  def edit
    @consulta = Consulta.find(params[:id])
    @terapeutas = Terapeuta.all
    @pacientes = Paciente.all 
    @from_controller = 'yes';
  end

  # POST /consultas
  # POST /consultas.xml
  def create
    @consulta = Consulta.new(params[:consulta])
    @consulta.formatar_data_hora_consulta params[:consulta][:hora_consulta], params[:consulta][:dia_consulta]
    disponivel = Consulta.verificar_disponibilidade Consulta.formatar_hora_consulta(@consulta.data_consulta), @consulta.data_consulta.to_date.wday() - 1, @consulta.terapeuta_id
    
    
    respond_to do |format|
      if disponivel && @consulta.save
        flash[:notice] = 'Consulta cadastrada com sucesso.'
        format.html { redirect_to(@consulta) }
        format.xml  { render :xml => @consulta, :status => :created, :location => @consulta }
      else
        @terapeutas = Terapeuta.all
        @pacientes = Paciente.all
        format.html { render :action => "new" }
        format.xml  { render :xml => @consulta.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /consultas/1
  # PUT /consultas/1.xml
  def update
    @consulta = Consulta.find(params[:id])

    respond_to do |format|
      if  @consulta.update_attributes(params[:consulta])
        flash[:notice] = 'Consulta atualizada com sucesso.'
        format.html { redirect_to(@consulta) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @consulta.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /consultas/1
  # DELETE /cconsultas/1.xml
  def destroy
    @consulta = Consulta.find(params[:id])
    @consulta.destroy
    flash[:notice] = 'Consulta removida com sucesso.'

    respond_to do |format|
      format.html { redirect_to(consultas_url) }
      format.xml  { head :ok }
    end
  end
end


