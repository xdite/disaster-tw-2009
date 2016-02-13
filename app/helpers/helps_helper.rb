module HelpsHelper
  def add_url_link(name) 
    link_to_function name do |page| 
      page.insert_html :bottom, :urls, :partial => 'url', :object => Url.new 
    end 
  end 


  def show_url(url)
    unless url.title.blank?
      return link_to(url.title,url.link)
    else
      return link_to(url.link,url.link)
    end
  end
  
  def report_it(post)
    "&nbsp; | &nbsp;" + link_to("[檢舉]", hash_for_report_help_path(:id => post.id ),{ :method => :put })
  end
  
  def revert_it(post)
    link_to("[回復]", hash_for_revert_admin_help_path(:id => post.id ),{ :method => :put })
  end
  
  def show_ip(post)
    
    return "[by 站長]" if post.created_ip == "60.199.247.200"
    
    unless post.created_ip.blank?
      
      return "[留言者 IP : #{post.created_ip}]"
    else
      return ""
    end
  end
  
  def admin_edit_post_bar(post)
    if current_user && current_user.is_admin?
      return "&nbsp;"+link_to("[編輯]", edit_admin_help_path(post)) + " / " + link_to('刪除',  admin_help_path(post), :title => "Delete this post", :confirm => "Are you sure?", :method => :delete) + " / " +link_to("[下架]", hash_for_report_help_path(:id => post.id ),{ :method => :put })
    else
      return ""
    end
  end
  
  def admin_edit_comment_bar(comment)
    if current_user && current_user.is_admin?
      return "&nbsp;"+link_to("編", edit_admin_comment_path(comment)) + " / " + link_to('刪',  admin_comment_path(comment), :title => "Delete", :confirm => "Are you sure?", :method => :delete)
    else
      return ""
    end
  end
 
  def show_comment_ip(comment)
    return "[by 站長]" if comment.created_ip == "60.199.247.200"
    return "[by 嘉義縣災變中心]" if comment.created_ip == "210.241.44.34"
    unless comment.created_ip.blank?
      return "[IP : #{comment.created_ip}]"
    else
      return ""
    end
  end
  
  def show_source_type(post)
    unless post.source_type_id.blank?
      return "&nbsp;[#{post.source_type.name}]&nbsp;"
    else
      return ""
    end
  end
  def pack_g_object(post)
    o = Hash.new
    o["location"] = post.county.location
    o["location_name"] = post.county.name
    o["subject"] = "<a href ='/helps/#{post.id}'>#{j(post.subject)}</a>"
    o["content"] = j(post.content[0..280])
    o["user"] = j("")
    if post.county.id <= 3
      o["zoom"] = 15
    else
      o["zoom"] = 7
    end
    return o 
  end
  
end
