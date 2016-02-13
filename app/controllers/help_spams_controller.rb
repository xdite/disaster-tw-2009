class HelpSpamsController < ApplicationController
  before_filter :find_post
  include FaceboxRender
  def new
    respond_to do |format|
     format.html
     format.js { render_to_facebox }
    end
  end
  def create
    @post_spam = @post.post_spams.build(params[:post_spam])
    if @post_spam.save
      notice_stickie "檢舉成功，感謝你的幫忙"
      redirect_to help_path(@post)
    else
      error_stickie "must fillup username / cotent"
      redirect_to help_path(@post)
    end
  end
end
