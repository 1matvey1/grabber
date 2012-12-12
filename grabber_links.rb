class Grabber
require 'open-uri'
Myfile = File.new("links.txt", "w+")
attr_accessor :url,:page,:text,:links,:level,:buf,:url_gets

	def grabber_links(url,lvl)
	url_gets = [url]
	buf = []
	links = []
	level = lvl.to_i
        
		for i in 1..level
                         
			 url_gets.each do |j|
                         begin
                         	links = self.search_links(j)   
			 	self.save_txt(j, links, i)
			 	buf = buf + links
                         rescue
                         end
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
	
		Myfile.puts('level '+level.to_s + ' : ')
		Myfile.puts(url + '  : ')
			links.each do |i|
                          Myfile.puts(i)  
		end
	end

	def links_other_recources(link,url)
	link = link.to_s
		if link.casecmp(url) == 0 || link.casecmp(url+'/') == 0
	        	return ''
		elsif link.include?("http://") == true
               		return link       
                else
                	return url + link  	     	
		end       
	end
end
grabber=Grabber.new
puts 'write site(http://name_site)'
url = gets
puts 'enter the level : '
level = gets
txt = grabber.grabber_links(url,level)
p txt






