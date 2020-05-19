class RatingsController < ApplicationController

  before_action :check_user, only: [:create]
  def index
    @ratings_and_feedbacks = Asset.find(params[:asset_id]).ratings
  end
  
  def create
    @asset = Asset.find(params[:asset_id])
    @rating_and_feedback = @asset.ratings.build(rating_params)
    @rating_and_feedback.user_id = current_user.id
    if @rating_and_feedback.save
      flash[:success] = "Rating posted successfully"
      redirect_to asset_path(params[:asset_id])
    else
      flash[:danger] = "Error while saving your feedback"
    end
  end

  private

  def rating_params 
    params.require(:rating).permit(:score, :feedback)
  end

  def check_user
    unless user_signed_in?
      flash[:warning] = "Sign up/in is required for this action"
      redirect_to new_user_session_path
    end
  end

end
