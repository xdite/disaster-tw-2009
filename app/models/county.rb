# == Schema Information
# Schema version: 20090813051410
#
# Table name: counties
#
#  id          :integer(4)      not null, primary key
#  name        :string(255)
#  location    :string(255)
#  posts_count :integer(4)      default(0)
#  created_at  :datetime
#  updated_at  :datetime
#

class County < ActiveRecord::Base
  has_many :posts
  validates_presence_of :name, :location
end
