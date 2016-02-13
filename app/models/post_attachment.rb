# == Schema Information
# Schema version: 20090813051410
#
# Table name: post_attachments
#
#  id           :integer(4)      not null, primary key
#  parent_id    :integer(4)
#  content_type :string(255)
#  filename     :string(255)
#  thumbnail    :string(255)
#  size         :integer(4)
#  width        :integer(4)
#  height       :integer(4)
#  post_id      :integer(4)
#  user_id      :integer(4)
#  created_at   :datetime
#  updated_at   :datetime
#

class PostAttachment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  
 #has_attachment :content_type => ['application/pdf', :image],
 ## 可擴充
 #  :storage => :file_system,
 #  :max_size => 1000.kilobytes,
 #  :resize_to => '500x500>',
 #  :thumbnails => { :thumb => '100x100>' },
 #  :path_prefix => 'public/attachments',
 #  :processor => :Rmagick
 #
 #validates_as_attachment
  
  named_scope :recent, :conditions => { :thumbnail => nil} , :limit => 5
  
end
