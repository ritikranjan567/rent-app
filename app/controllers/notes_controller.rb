class NotesController < ApplicationController
  
  def create
    @request = Request.find(params[:request_id])
    @note = @request.notes.build(note_params)
    @note.user = current_user
    if @note.save
      flash[:success] = "Note successfully added"
      redirect_to notes_path
    else
      flash[:danger] = "Request couldn't be saved"
      redirect_to notes_path
    end
  end

  def index
    @request = Request.find(params[:request_id])
    @notes = @request.notes  
  end

  private

  def note_params
    params.require(:note).permit(:content)
  end
end
