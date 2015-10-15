class CaptionsController < ApplicationController
  def create
    @user = current_user
    if params[:image_id]
      @current_image = Image.find(params[:image_id])
      @caption = @current_image.captions.new(caption_params)
    else
      @parent = Caption.find(params[:caption_id])
      @caption = @parent.captions.new(caption_params)
    end
    @caption.user_id = @user.id
    session[:return_to] ||= request.referer
    if @caption.save
      redirect_to session.delete(:return_to)
    else
      redirect_to images_path
    end
  end

  private
  def caption_params
    params.require(:caption).permit(:text)
  end
end
