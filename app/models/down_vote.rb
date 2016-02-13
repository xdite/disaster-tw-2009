# == Schema Information
# Schema version: 20090813051410
#
# Table name: down_votes
#
#  id         :integer(4)      not null, primary key
#  post_id    :integer(4)
#  created_ip :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

class DownVote < ActiveRecord::Base
  belongs_to :post ,:counter_cache => true 
end
