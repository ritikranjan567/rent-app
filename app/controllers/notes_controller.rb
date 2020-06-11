class NotesController < ApplicationController
  
  def create
    @request = Request.find(params[:request_id])
    @note = @request.notes.build(note_params)
    @note.user = current_user
    if @note.save
      flash[:success] = "Note successfully added"
      redirect_to show_request_bookings_path(@request)
    else
      flash[:danger] = "Request couldn't be saved"
      redirect_to show_request_bookings_path(@request)
    end
  end

  def destroy
    @note = Note.find(params[:id])
    authorize @note
    if @note.destroy
      flash[:success] = 'Note has been successfully deleted.'
      redirect_to show_request_bookings_path(params[:request_id])
    else
      flash[:error] = 'Unable to delete the request'
      redirect_to show_request_bookings_path(params[:request_id])
    end
  end
  
  private

  def note_params
    params.require(:note).permit(:content)
  end
end
