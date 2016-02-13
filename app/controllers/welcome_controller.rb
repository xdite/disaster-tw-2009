class WelcomeController < ApplicationController
  
  def index
    redirect_to helps_path
  end
  
  def donate
    @page_title = "捐贈物資管道"
  end
  
  def donate_money
    @page_title = "捐款、募款資訊"
  end
  
  def recruit
    @page_title = "招募志工"
    redirect_to recruit_long_path
  end
  
  def donate_buy
    @page_title = "物資協購 & 免費運送"
  end
  
 # def recruit_short
 #   @page_title = "志工招募(即時)"
 # end
  
  def recruit_registrano
    @page_title = "招募水災重整家園志工"
  end
  
  def recruit_long
    @page_title = "招募志工（長期）"
  end
  
  def recruit_guide
    @page_title = "招募志工開團教學"
  end
  
  def search
    @page_title = "站內搜尋"
  end 
end
