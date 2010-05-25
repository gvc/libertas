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
    
    unless params[:pd]
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
    
    if @consulta.save
      flash[:notice] = 'Consulta cadastrada com sucesso.'
      redirect_to(@consulta)
    else
      @terapeutas = Terapeuta.all
      @pacientes = Paciente.all
      render :action => "new"
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

    redirect_to(consultas_url)
  end
end


