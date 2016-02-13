# == Schema Information
# Schema version: 20090813051410
#
# Table name: miscs
#
#  id         :integer(4)      not null, primary key
#  content    :text
#  misc_type  :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Misc < ActiveRecord::Base
end
