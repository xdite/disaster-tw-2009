xml.instruct! :xml, :version=>"1.0" 
xml.feed(:xmlns => "http://www.w3.org/2005/Atom") do |feed|
  feed.title('Atom Feed')
  feed.link('http://disastertw.com/')
  for post in @posts do
    feed.entry do |entry|
      entry.id(post.id)
      entry.title("[#{post.county.name}]" + "[#{post.help_type.name }]"  + post.subject)
      entry.content("(#{post.source_type.name})" + post.content, :type => 'text')
      entry.updated(post.updated_at)
      entry.link(url_for(:action => 'show', :id => post.id))
      entry.author do |author|
        author.name post.created_ip
      end
    end
  end
end
