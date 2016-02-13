AutoHtml.add_filter(:sanitize).with({}) do |text, options|
  HTML::WhiteListSanitizer.new.sanitize(text)
end
