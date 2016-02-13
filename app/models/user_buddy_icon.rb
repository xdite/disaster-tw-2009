# == Schema Information
# Schema version: 20090813051410
#
# Table name: user_buddy_icons
#
#  id           :integer(4)      not null, primary key
#  type         :string(255)
#  parent_id    :integer(4)
#  content_type :string(255)
#  filename     :string(255)
#  thumbnail    :string(255)
#  size         :integer(4)
#  width        :integer(4)
#  height       :integer(4)
#  user_id      :integer(4)
#  created_at   :datetime
#  updated_at   :datetime
#

class UserBuddyIcon < ActiveRecord::Base
  belongs_to :user
  
# has_attachment :content_type => :image, 
#                :storage => :file_system, 
#                :path_prefix => 'public/upload/images',
#                :max_size => 500.kilobytes, 
#                :resize_to => [80,80],
#                :thumbnails => { :small => [32,32], :tiny => [16,16] }
#
# validates_as_attachment
end
