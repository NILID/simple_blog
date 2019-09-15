class NotesController < ApplicationController
  load_and_authorize_resource except: [:index]

  load_resource :user, find_by: :slug, only: [:index]
  load_and_authorize_resource :note, through: [:user], only: [:index]

  def index
    @notes = @notes.order(created_at: :desc).includes(:taggings)
  end

  def show
    @containers = @note.containers.order(:position).includes(:slides)
  end

  def new;  end
  def edit; end

  def create
    @note.user = current_user
    respond_to do |format|
      if @note.save
        format.html { redirect_to [@user, @note], notice: 'Note was successfully created.' }
        format.json { render :show, status: :created, location: @note }
      else
        format.html { render :new }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @note.update(note_params)
        format.html { redirect_to [@user, @note], notice: 'Note was successfully updated.' }
        format.json { render :show, status: :ok, location: @note }
      else
        format.html { render :edit }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @note.destroy
    respond_to do |format|
      format.html { redirect_to [@user, Note], notice: 'Note was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def note_params
      params.require(:note).permit(:title,
                                      :desc,
                                      :preview,
                                      :hide,
                                      :tag_list,
                                      :containers_attributes => [:id,
                                                              :content,
                                                              :types_mask,
                                                              :_destroy,
                                                              [ slides_attributes: [:id, :slide, :_destroy]]]
                                    )
    end
end
