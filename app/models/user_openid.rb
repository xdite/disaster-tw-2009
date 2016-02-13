# == Schema Information
# Schema version: 20090813051410
#
# Table name: user_openids
#
#  id         :integer(4)      not null, primary key
#  openid_url :string(255)     not null
#  user_id    :integer(4)      not null
#  created_at :datetime
#  updated_at :datetime
#

class UserOpenid < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :openid_url
  validates_uniqueness_of :openid_url

  def denormalized_url                                                      
    self.openid_url.gsub(%r{^https?://}, '').gsub(%r{/$},'')                
  end    
end
