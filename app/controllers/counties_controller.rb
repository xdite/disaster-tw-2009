class CountiesController < ApplicationController
  def index
    @counties = County.paginate(:page => params[:page], :per_page => 20, :order => "posts_count DESC")
    @page_title ="地區災情"
  end
  
  def show
    @county = County.find(params[:id])
    @page_title = @county.name
   
    
    if params[:help_type]
      @posts = @county.posts.not_spam.paginate(:page => params[:page], :per_page => 20, :order => "id DESC", :conditions => [ "help_type_id = ? " , params[:help_type].to_i ])
      @page_title += " - " + HelpType.find(params[:help_type].to_i).name
    else
      @posts = @county.posts.not_spam.paginate(:page => params[:page], :per_page => 20, :order => "id DESC")
    end

  end
end
