class Admin::CommentsController < ApplicationController
  before_filter :login_required
  before_filter :require_admin

  def index
    @comments = PostComment.paginate(:page => params[:page], :per_page => 50, :order => "id DESC")
  end
  
  def edit
    @comment = PostComment.find(params[:id])
  end

  
  def update
    @comment = PostComment.find(params[:id])
      if @comment.update_attributes(params[:post_comment])
        notice_stickie "Update Success"
        redirect_to :back
      else
        render :action => "edit"
      end
  end

  def destroy
    @comment = PostComment.find(params[:id])
    @comment.destroy
    notice_stickie "Delete Success"
    redirect_to :back
  end
end
