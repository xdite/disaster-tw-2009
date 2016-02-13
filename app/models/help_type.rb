# == Schema Information
# Schema version: 20090813051410
#
# Table name: help_types
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class HelpType < ActiveRecord::Base
end
