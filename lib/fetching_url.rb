require File.dirname(__FILE__) + '/../app/models/url.rb' 
require 'rubygems'
require 'hpricot'
require 'open-uri'
require 'net/http'
require 'charguess'
require 'iconv'
class FetchingUrl
  def self.run
    begin 
      url = Url.find_url_to_fetch
    raise ActiveRecord::RecordNotFound if url.nil?
      url.start_title_fetching!
      FetchingUrl.fetch_title(url)
      FetchingUrl.fetch_pic(url)
      url.finish_title_fetching!
    rescue ActiveRecord::StaleObjectError 
      # do nothing
    rescue ActiveRecord::RecordNotFound 
      sleep 10 
    rescue 
      return unless url  
      url.processing_error! 
      url.update_attributes(:processing_error_message => "unknown error: #{$!}") 
    end
  end
  
  def self.fetch_pic(post_url)
    url = URI.parse("http://ppt.cc/yo2/api.php?url="+post_url.link)
    http = Net::HTTP.new(url.host,url.port)
    cookie = "BX=#{Time.now.to_i.to_s}"
    headers = {
      "Cookie" => cookie,
      "User-Agent" => "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1)"
    }
    

    response = http.request_get(url.request_uri,headers) 
    http.read_timeout = 5
    http.open_timeout = 5
    
     if response.code == "200"
       ppt_response = response.body
       post_url.ppt_url = ppt_response
     else
       post_url.ppt_url = "0"
     end
     
      post_url.save
  end
       
  def self.fetch_title(post_url)
    url = URI.parse(post_url.link)
    http = Net::HTTP.new(url.host,url.port)
    cookie = "BX=#{Time.now.to_i.to_s}"
    headers = {
      "Cookie" => cookie,
      "User-Agent" => "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1)"
    }

    response = http.request_get(url.request_uri,headers) 
    http.read_timeout = 2
    http.open_timeout = 2
    
    if response.code == "200"
      
      doc = Hpricot(response.body)
      encoding = CharGuess.guess(response.body)
      title = doc.search("//title").inner_html.lstrip.rstrip
      ic = Iconv.new('UTF-8',encoding)
      post_url.title = ic.iconv(title)
      
    elsif response.code == "301" ||  response.code == "302"
      page = open(post_url.link)
      doc = Hpricot(page)
      encoding = CharGuess.guess(doc.search("//title/").inner_html)
      title = doc.search("//title").inner_html.lstrip.rstrip
      ic = Iconv.new('UTF-8',encoding)
      post_url.title = ic.iconv(title)
      
    else
      title = ""
    end
    post_url.save
  end
  
end
