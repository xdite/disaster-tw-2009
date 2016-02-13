class HelpCommentsController < ApplicationController
  before_filter :find_post
  include FaceboxRender
  def new
    respond_to do |format|
     format.html
     format.js { render_to_facebox }
    end
  end
  def create
    @post_comment = @post.post_comments.build(params[:post_comment])
    @post_comment.created_ip = request.remote_ip || ""
    
    @filter = Misc.find(1).content.split(',')
    if @filter.include?(@post_comment.created_ip) || @post_comment.content.include?("山達基") || @post_comment.content.include?("http://bit.ly/EaWwy")
      error_stickie("請不要來亂")
      redirect_to help_path(@post)
    elsif @post_comment.save
     # current_user.post_comments << @post_comment if current_user
      notice_stickie "leave comment success"
      redirect_to help_path(@post)
    else
      error_stickie "must fillup username / cotent"
      redirect_to help_path(@post)
    end
  end
end
