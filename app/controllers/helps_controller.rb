class HelpsController < ApplicationController
  before_filter :require_admin, :except => ["index"] 
  def index
    @page_title = "請求支援列表"
    if params[:help_type]
      @page_title += " - " + HelpType.find(params[:help_type].to_i).name
      @posts = Post.not_spam.paginate(:page => params[:page], :per_page => 50, :order => "id DESC", :conditions => [ "help_type_id = ? " , params[:help_type].to_i ])
    else
      @posts = Post.not_spam.paginate(:page => params[:page], :per_page => 50, :order => "id DESC")
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.atom # index.atom.builder
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
    @page_title = "刊登資訊 / 發出求救 "
  end
  
  
  def create
    
    @post = Post.new(params[:post])
    @post.created_ip = request.remote_ip || ""

    if session[:last_post] && (Time.now - Time.parse(session[:last_post].to_s) < 1800 )
      error_stickie("30 分鐘內你只能發表一篇文章")
      render :action => "new"
      return 
     end 
    
    @filter = Misc.find(1).content.split(',')
    first_ip = @post.created_ip.split(".").first
    if @filter.include?(@post.created_ip) || @post.is_spam? || (62..100).include?(first_ip.to_i) || [1..50].include?(first_ip.to_i)
      error_stickie("請不要來亂。")
      session[:last_post] = (Time.now + 3.hours)
      redirect_to helps_path  
    elsif @post.save
      session[:last_post] = Time.now
      notice_stickie("感謝您！")
      redirect_to helps_path
    else
      render :action => "new"
    end
  end
  
  def report
    @post = Post.find(params[:id])
    @reporter_ip = request.remote_ip
    
    if current_user && current_user.is_admin?
      @post.spams_count = 3
      @post.save(false)
      warning_stickie("成功下架")
      redirect_to :back
      return 
    end
    
    @spam_report = Spam.find_or_initialize_by_created_ip_and_post_id(@reporter_ip,@post.id)
    if @spam_report.new_record?
      @spam_report.save
      warning_stickie("感謝你的回報，我們會儘速處理此文")
    else
      warning_stickie("你已經回報過了")
    end
    redirect_to :back
  end

end
