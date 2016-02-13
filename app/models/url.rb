# == Schema Information
# Schema version: 20090813051410
#
# Table name: urls
#
#  id                       :integer(4)      not null, primary key
#  link                     :string(255)
#  title                    :string(255)
#  ppt_url                  :string(255)
#  state                    :string(255)
#  processing_error_message :string(255)
#  post_id                  :integer(4)
#  created_at               :datetime
#  updated_at               :datetime
#

class Url < ActiveRecord::Base
  belongs_to :post

  validates_url_of :link, :message => 'is not valid or not responding'
  

  
  acts_as_state_machine :initial => :pending 
  state :pending 
  state :processing 
  state :complete 
  state :error
  
  event :start_title_fetching do 
    transitions :from => :pending, :to => :processing 
  end 
  
  event :finish_title_fetching do 
    transitions :from => :processing, :to => :complete 
  end 
  
  event :processing_error do 
    transitions :from => :processing, :to => :error 
  end 
  
  def self.find_url_to_fetch
    find(:first, 
    :conditions => "state = 'pending'", 
    :order => "created_at") 
  end 

  def generate_pdf 
    
    logger.info("Generating #{title} PDF...") 
    # Insert your long-running code here to generate PDFs. 
  end
  
end
