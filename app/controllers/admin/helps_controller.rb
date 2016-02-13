class Admin::HelpsController < ApplicationController
  before_filter :login_required
  before_filter :require_admin
    
  include HelpsHelper

  
  def index
    
    if params[:admin_type] && params[:admin_type] == "is_spam"
      @posts = Post.is_spam.paginate(:page => params[:page], :per_page => 50, :order => "id DESC")
    else
      @posts = Post.not_spam.paginate(:page => params[:page], :per_page => 50, :order => "id DESC")
    end
  end
  
  def show
    @post = Post.find(params[:id])
    @page_title = @post.subject
    @post_comments = @post.post_comments.paginate(:page => params[:page], :per_page => 20)
  end
  
  def new
    @post = Post.new
    @post.urls.build
    @page_title = "求援專線"
  end
  
  def edit
    @post = Post.find(params[:id])

  end
  
  def create
    @post = Post.new(params[:post])
    if @post.save
      redirect_to admin_helps_path
    else
      render :action => "new"
    end
  end
  
  def update
    @post = Post.find(params[:id])
    params[:post][:existing_url_attributes] ||= {} 
      if @post.update_attributes(params[:post])
        notice_stickie "Update Success"
        redirect_to :back
      else
        render :action => "edit"
      end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    notice_stickie "Delete Success"
    redirect_to :back
  end
  
  def revert
    @post = Post.find(params[:id])
    @post.spams_count = 0
    @post.spams.each do |s|
      s.destroy
    end
    @post.save(false)
    notice_stickie("回復成功")
    redirect_to :back
  end
end
