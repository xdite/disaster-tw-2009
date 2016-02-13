class Admin::MiscsController < ApplicationController
  before_filter :login_required
  before_filter :require_admin
  
  def ip
    @misc = Misc.find(params[:id])

  end
  
  def keywords
     @misc = Misc.find(params[:id])
  end

  def update
    @misc = Misc.find(params[:id])
      if @misc.update_attributes(params[:misc])
        notice_stickie "Update Success"
        redirect_to :back
      else
        render :action => "edit"
      end
  end

end
