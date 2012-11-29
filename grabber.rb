class Grabber
require 'open-uri'
Myfile = File.new("links.txt", "w+")
attr_accessor :url,:page,:text,:links,:level,:buf,:url_gets

def grabber_links(url)
   url_gets = [url]
   buf = []
   links = []
   puts 'enter the level : '
   level = gets
   level = level.to_i
   for i in 1..level
      for j in 0..url_gets.size-1
         links = self.search_links(url_gets[j])
         self.save_txt(url_gets[j], links, i)
         buf = buf + links
      end
     url_gets = buf
     buf = []
   end
 'save for links.txt'
end

def search_links(url_new)
   url = url_new
   page = open(url)
   text = page.read
   links = text.scan(/<a href=\"(.*?)\"/)
   links = links.collect{|link| link=links_other_recources(link, url)}-['']
   links
end
def save_txt(url, links, level)

   Myfile.puts('level '+level.to_s+ ' : ')
   Myfile.puts(url + '  : ')
   for i in 0..links.size - 1 
     Myfile.puts(links[i])  
   end
end

def links_other_recources(link,url)
   link = link.to_s
   if  link.casecmp('http')>0 && link.casecmp(url)<0 ||link.casecmp(url)>0
      return link
   end
   ''
end
end
grabber=Grabber.new
url = 'http://forifish.ho.ua/'
txt = grabber.grabber_links(url)
p txt






