# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def cache_partial(id, options = {}, &block)
    return block.call unless MEMCACHE

    cache_data = MEMCACHE.get(id)    
    if cache_data
      return cache_data
    else
      data = block.call
      MEMCACHE.set(id, data, options[:expire] || 300)
      return data
    end
  end
    
  def salutation_menu
    menu = HandicraftHelper::Menu.new
    if logged_in?
      menu << ["Settings", edit_user_path(current_user) ]
      menu << ["Logout", logout_path ]
      if current_user.is_admin?
        menu << ["管理界面", admin_path]
      end
    else
      menu << ["<big><big>[推到 Plurk!]</big></big>","#" ,  {:onClick => "javascript: void(window.open('http://www.plurk.com/?qualifier=shares&status=' .concat(encodeURIComponent(location.href)) .concat(' ') .concat('&#40;') .concat(encodeURIComponent(document.title)) .concat('&#41;').concat('&nbsp;&nbsp; ')));"}]
      #menu << ["Login", login_path ]
      #menu << ["註冊", signup_path]
     # menu << ["使用雅虎奇摩帳號登入", account_yahooLogin_path ]
    end

    return menu
  end

  def navigation_menu
    menu = HandicraftHelper::Menu.new
    menu << ["首頁", "/"]
    #menu << ["地區災情", counties_path]
    #menu << ["[刊登資訊 / 發出求救]", new_help_path]
    menu << ["捐贈物資資訊", donate_path]
    menu << ["捐款、募款資訊", donate_money_path ]
     menu << ["!! 志工招募 !!", recruit_path]
    menu << ["站內搜尋", search_path ]
    menu << ["連絡站長", contact_path ]
    if logged_in?
         #menu << ["Bar2", ""]
    end

    return menu
  end

  def footer_menu 
    menu = HandicraftHelper::Menu.new
    menu << ["About", "/about"]
   # menu << ["API", "/api"]
    return menu
  end


  
  def render_page_title
    title = @page_title ? " | #{@page_title}" : ''
    "<title> 莫拉克颱風災情支援網 #{title}</title>"
  end

  def yield_or_default(message, default_message = "")
     message.nil? ? default_message : message
  end
  
end
