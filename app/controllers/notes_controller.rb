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

  def destroy
    @note = Note.find(params[:id])
    authorize @note
    if @note.destroy
      flash[:success] = 'Note has been successfully deleted.'
      redirect_to notes_path
    else
      flash[:error] = 'Unable to delete the request'
      redirect_to notes_path
    end
  end
  
  private

  def note_params
    params.require(:note).permit(:content)
  end
end
