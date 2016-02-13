# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  helper HandicraftHelper
  include AuthenticatedSystem
  include SimpleCaptcha::ControllerHelpers  



  protect_from_forgery # :secret => 'c364b9cbcd9574e950292429491e4ea9'

  def require_admin
    unless logged_in? && current_user.is_admin
      error_stickie "You don't have permission to access."
      redirect_back_or_default home_path
      return false
    end
  end
  
  def find_post
    @post = (params[:help_id])? Post.find(params[:help_id]) : Post.find(params[:id]) 
  end

end
