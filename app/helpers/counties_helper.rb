module CountiesHelper
  def show_last_post(county)
    if county.posts_count > 0
      return link_to(h(county.posts.last.subject),help_path(county.posts.last)) if county.posts.last
    else
    end
  end
  
  def show_last_post_time(county)
    if county.posts_count > 0
      return county.posts.last.created_at if county.posts.last
    else
    end
  end
end
