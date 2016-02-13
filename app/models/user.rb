# == Schema Information
# Schema version: 20090813051410
#
# Table name: users
#
#  id                        :integer(4)      not null, primary key
#  login                     :string(40)
#  name                      :string(100)     default("")
#  email                     :string(100)
#  crypted_password          :string(40)
#  salt                      :string(40)
#  site_url                  :string(255)
#  yahoo_userhash            :string(255)
#  gender                    :string(255)
#  description               :text
#  is_admin                  :boolean(1)
#  created_at                :datetime
#  updated_at                :datetime
#  remember_token            :string(40)
#  remember_token_expires_at :datetime
#  posts_count               :integer(4)      default(0)
#  post_comments_count       :integer(4)      default(0)
#  identity_url              :string(255)
#

require 'digest/sha1'

class User < ActiveRecord::Base
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken

  has_many :openids, :class_name => "UserOpenid", :dependent => :destroy
  has_one :buddy_icon, :class_name => "UserBuddyIcon", :dependent => :destroy

  before_validation_on_create :make_user_openid

  validates_presence_of     :login
  validates_length_of       :login,    :within => 3..40
  validates_uniqueness_of   :login,    :case_sensitive => false
  validates_format_of       :login,    :with => RE_LOGIN_OK, :message => MSG_LOGIN_BAD

  validates_format_of       :name,     :with => RE_NAME_OK,  :message => MSG_NAME_BAD, :allow_nil => true
  validates_length_of       :name,     :maximum => 100

  validates_presence_of     :email
  validates_length_of       :email,    :within => 6..100 #r@a.wk
  validates_uniqueness_of   :email,    :case_sensitive => false
  validates_format_of       :email,    :with => RE_EMAIL_OK, :message => MSG_EMAIL_BAD
  validates_url_of          :site_url, :message => 'is not valid or not responding'
  
  has_many :posts
  has_many :post_attachments,:dependent => :destroy
  has_many :urls,:dependent => :destroy
  has_many :post_comments,:dependent => :destroy
  
  def make_user_openid
    self.openids.build(:openid_url => identity_url) unless identity_url.blank?
  end

  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :name, :password, :password_confirmation, :identity_url, :site_url, :description,:yahoo_userhash



  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  #
  # uff.  this is really an authorization, not authentication routine.  
  # We really need a Dispatch Chain here or something.
  # This will also let us return a human error message.
  #
  def self.authenticate(login, password)
    u = find_by_login(login) # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  protected
    
  def password_required?
    identity_url.blank? && yahoo_userhash.blank? && (crypted_password.blank? || !password.blank?)
  end

end
