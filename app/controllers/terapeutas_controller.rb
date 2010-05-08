class TerapeutasController < ApplicationController
  def index
    @terapeutas = Terapeuta.all
  end

  def new
    @terapeuta = Terapeuta.new
    @terapeuta.build_funcionario.build_pessoa.telefones.build
    @terapeuta.funcionario.pessoa.build_endereco
  end

  def create
    @terapeuta = Terapeuta.new(params[:terapeuta])
    if @terapeuta.save
      redirect_to(@terapeuta)
    else
      render :action => :new
    end
  end

  def edit
    @terapeuta = Terapeuta.find(params[:id])
  end

  def update
    @terapeuta = Terapeuta.find(params[:id])
    if @terapeuta.update_attributes(params[:terapeuta])
      flash[:notice] = 'Paciente atualizado com sucesso.'
      redirect_to(@terapeuta)
    else
      render :action => :edit
    end
  end

  def destroy
    @terapeuta = Terapeuta.find(params[:id])
    @terapeuta.destroy
    flash[:notice] = 'Terapeuta removido com sucesso.'
    redirect_to(terapeutas_url)
  end

  def show
    @terapeuta = Terapeuta.find(params[:id])
  end

end
