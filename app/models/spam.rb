# == Schema Information
# Schema version: 20090813051410
#
# Table name: spams
#
#  id         :integer(4)      not null, primary key
#  post_id    :integer(4)
#  content    :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

class Spam < ActiveRecord::Base
  belongs_to :post, :counter_cache => true
  
  after_create :auto_destroy_post
  
  def auto_destroy_post
    if self.post.spams_count > 10
      self.post.content += "zzzz"
      @filters = Misc.find(1)
      @filters.content += ",#{self.post.created_ip}"
      @filters.save
    end
  end
end
