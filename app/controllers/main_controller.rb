class MainController < ApplicationController
  def index
    @last_notes = if params[:by_tag]
                    Note.tagged_with(params[:by_tag])
                  else
                    Note
                  end
    @last_notes = @last_notes.where(hide: false).order(created_at: :desc).limit(9).includes(:taggings)
  end
end
