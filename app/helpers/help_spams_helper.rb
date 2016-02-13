module HelpSpamsHelper
  def report_spam(post)
    link_to('檢舉', hash_for_help_comments_path(post))
  end
end
