# == Schema Information
# Schema version: 20090813051410
#
# Table name: post_comments
#
#  id           :integer(4)      not null, primary key
#  content      :text
#  username     :string(255)
#  post_id      :integer(4)
#  user_id      :integer(4)
#  created_ip   :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#  content_html :text
#

class PostComment < ActiveRecord::Base
  belongs_to :user,:counter_cache => true 
  validates_presence_of :content
  belongs_to :post ,:counter_cache => true 
  
  named_scope :recent_5 , :order => "id DESC" , :limit => 5
  
  auto_html_for :content do
    html_escape
    image
    youtube :width => 400, :height => 250
    link :target => "_blank", :rel => "nofollow"
    simple_format
  end
  
end
