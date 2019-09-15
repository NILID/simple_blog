class ContainersController < ApplicationController
  load_resource :note, except: [:sort]
  load_and_authorize_resource :container, through: %i[note], except: [:sort]

  def new
    @type = params[:type]
    respond_to do |format|
      format.html
      format.js { render layout: false }
    end
  end

  def edit; end

  def sort
    params[:container].each_with_index do |id, index|
      Container.where(id: id).update_all({ position: index + 1 })
    end
    render body: nil
  end

  def create
    respond_to do |format|
      if @container.save
        format.html { redirect_to @note, notice: 'Container was successfully created.' }
        format.json { render :show, status: :created, location: @container }
        format.js   { render layout: false }
      else
        format.html { render :new }
        format.json { render json: @container.errors, status: :unprocessable_entity }
        format.js   { render layout: false }
      end
    end
  end

  def update
    respond_to do |format|
      if @container.update(container_params)
        format.html { redirect_to @note, notice: 'Container was successfully updated.' }
        format.json { render :show, status: :ok, location: @container }
      else
        format.html { render :edit }
        format.json { render json: @container.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @container.destroy
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  private
    def container_params
      params.require(:container).permit(
        :content,
        :note_id,
        :types_mask,
        :types,
        [ slides_attributes: [:id, :slide, :_destroy]]
        )
    end
end
