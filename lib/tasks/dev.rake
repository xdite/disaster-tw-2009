namespace :dev do

  desc "Rebuild system"
  task :build => ["tmp:clear","db:drop", "db:create", "db:migrate", :setup, :create_counties, :fake_post, :ip, :keywords, :source_type]
  
  desc "Setup system data"
  task :setup => :environment do

      puts "Create system user"
      u = User.create!(:login => "xdite", :password => "pixxpixx", :password_confirmation => "pixxpixx" , :email => "xdite@pinet.tw" )
      u.is_admin = true
      u.save
      o = UserOpenid.new(:user_id => u.id, :openid_url => "http://openid.claimid.com/xdite")
      o.save
  end
  
  
  desc "create_counties"
  task :create_counties => :environment do

      puts "Create Counties"
      c = County.create!(:name => "台北縣", :location => "台北縣" )
      c = County.create!(:name => "台北市", :location => "台北市" )
      c = County.create!(:name => "基隆市", :location => "基隆市" )
      c = County.create!(:name => "桃園縣", :location => "桃園縣" )
      c = County.create!(:name => "新竹縣", :location => "新竹縣" )
      c = County.create!(:name => "新竹市", :location => "新竹市" )
      c = County.create!(:name => "苗栗縣", :location => "苗栗縣" )
      c = County.create!(:name => "台中縣", :location => "台中縣" )
      c = County.create!(:name => "台中市", :location => "台中市" )
      c = County.create!(:name => "彰化縣", :location => "彰化縣" )
      c = County.create!(:name => "南投縣", :location => "南投縣" )
      c = County.create!(:name => "雲林縣", :location => "雲林縣" )
      c = County.create!(:name => "嘉義縣", :location => "嘉義縣" )
      c = County.create!(:name => "嘉義市", :location => "嘉義市" )
      c = County.create!(:name => "台南縣", :location => "台南縣" )
      c = County.create!(:name => "台南市", :location => "台南市" )
      c = County.create!(:name => "高雄縣", :location => "高雄縣" )
      c = County.create!(:name => "高雄市", :location => "高雄市" )
      c = County.create!(:name => "屏東縣", :location => "屏東縣" )
      c = County.create!(:name => "宜蘭縣", :location => "宜蘭縣" )
      c = County.create!(:name => "花蓮縣", :location => "花蓮縣" )
      c = County.create!(:name => "台東縣", :location => "台東縣" )
      c = County.create!(:name => "金門縣", :location => "金門縣" )
  end

  desc "fake_post"
  task :fake_post => :environment do
    puts "Create Post..."
    post1 = Post.create!(:subject => "去你媽媽的跌一半！", :content => "跌幅一半不過是從馬上死亡變成馬上漸漸死亡啦，那些官員到底有沒有玩過股票阿.....", :user_id => "1", :county_id => "2" ,:source_type_id => 1)
    url1 = Url.create!(:link => "http://1-apple.com.tw/index.cfm?Fuseaction=Article&Sec_ID=1&ShowDate=20081013&IssueID=20081013&art_id=31042046&NewsType=1&SubSec=66")
    post1.urls << url1
    post2 = Post.create!(:subject => "三聚氰胺", :content => "驅長你他媽自己喝吧", :user_id => "1", :county_id => "1",:source_type_id => 1)
    url2 = Url.create!(:link => "http://iservice.libertytimes.com.tw/liveNews/news.php?no=138812&type=%E5%8D%B3%E6%99%82%E6%96%B0%E8%81%9E")
    post2.urls << url2
  end
  
  desc "change column"
  task :help => :environment do
    h = HelpType.find(3)
    h.name = "提供物資"
    h.save!
    
    HelpType.create!(:name => "需要物資" )
  end
  
  desc "change column"
    task :admin => :environment do
      u = User.create!(:login => "kyddd", :password => "pixxpixx", :password_confirmation => "pixxpixx" , :email => "kydd@pinet.tw" )
      u.is_admin = true
      u.save
  end
  
  desc "auto_html"
  task :auto_html => :environment do
    Post.all.each do |p|
      p.content += ""
      p.save
      puts p.id
    end
    PostComment.all.each do |p|
      p.content += ""
      p.save
      puts p.id
    end
  end
  
  desc "create ip filter"
  task :ip => :environment do
    Misc.create!(:content => "141.76.45.35,141.76.45.34,78.142.140.194,83.91.86.29,192.251.226.206", :misc_type => "ip_filter")
  end
  
  desc "create keywords"
  task :keywords => :environment do
    Misc.create!(:content => "災場人員,莫拉克災民受到,http://bit.ly/er52U,http://bit.ly/EaWwy,http://tiny.cc/KNS3Y", :misc_type => "keyword_filter")
  end

  desc "補 count"
  task :counts => :environment do
    @posts = Post.find(:all, :conditions => ["spams_count is ?", nil ] )
    @posts.each do |p|
      p.spams_count = 0
      p.save(false)
      puts p.id
    end
  end
  desc "check ip"
  task :check_ip => :environment do 
    @posts = Post.all
    @posts.each do |p|
      unless p.created_ip.blank?
      ips = p.created_ip.split('.')
        puts p.id.to_s + "-" + p.created_ip
      end
    end
  end
  
  desc "source_type"
  task :source_type => :environment do 
    SourceType.create!(:name => "第一手來源")
    SourceType.create!(:name => "看新聞")
    SourceType.create!(:name => "轉貼")
    SourceType.create!(:name => "代貼")
  end

end
