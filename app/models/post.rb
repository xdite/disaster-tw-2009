# == Schema Information
# Schema version: 20090813051410
#
# Table name: posts
#
#  id                  :integer(4)      not null, primary key
#  county_id           :integer(4)
#  user_id             :integer(4)
#  subject             :string(255)
#  content             :text
#  down_votes_count    :integer(4)      default(0)
#  post_comments_count :integer(4)      default(0)
#  created_ip          :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#  help_type_id        :integer(4)      default(1)
#  content_html        :text
#  spams_count         :integer(4)      default(0)
#

class Post < ActiveRecord::Base
  
  #acts_as_taggable
  

  apply_simple_captcha
  belongs_to :user,:counter_cache => true 
  belongs_to :county,:counter_cache => true 
  belongs_to :help_type
  belongs_to :source_type
  
  validates_presence_of :subject, :content
  validates_inclusion_of :county_id, :in => 1..26
  #has_many :post_attachments, :dependent => :destroy
  has_many :urls,:dependent => :destroy
  has_many :post_comments,:dependent => :destroy
  has_many :spams,:dependent => :destroy
  
  #after_create :save_attachment
  after_update :save_urls
  

  
  named_scope :recent, :limit => 7 , :order => "id DESC"
  named_scope :not_spam , :conditions => "spams_count < 3"
  named_scope :is_spam , :conditions => "spams_count >= 3 "
  
  auto_html_for :content do
    html_escape
    image
    youtube :width => 400, :height => 250
    link :target => "_blank", :rel => "nofollow"
    simple_format
  end
  
  # http://www.runfatboy.net/blog/2008/05/16/allowing-multiple-uploads-attachment_fu-for-multi-model-forms/

  
  def is_spam?  
    @content = self.content.gsub(/\s/,' ').lstrip.rstrip
    filters = Misc.find(2).content.split(',')
    filters.each do |f|
      if @content.include?(f)
        return true
        break
      end
    end
    return false
  end
  
  def attachments=(attachments)
    unless attachments == [""]
      attachments.each do |file|
       @attachment = post_attachments.build({:uploaded_data => file}) 
     end
    end
  end
  
  def save_attachment
    if post_attachments
      post_attachments.each do |file|

        self.user.post_attachments << file
      end
    end
  end
  
  def new_url_attributes=(url_attributes) 
    url_attributes.each do |attributes| 
      urls.build(attributes) unless attributes["link"]=="http://"
    end 
  end
 
  
  def existing_url_attributes=(url_attributes) 
    urls.reject(&:new_record?).each do |url| 
      attributes = url_attributes[url.id.to_s] 
      if attributes 
        url.attributes = attributes 
      else 
        urls.delete(url) 
      end 
    end 
  end 
  
  def save_urls 
    urls.each do |url| 
      url.save(false) 
    end 
  end 
  
end
