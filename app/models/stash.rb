class Stash < ActiveRecord::Base
  attr_accessible :email, :body

  @url = 'http://www.fpa.com.au/default.asp?action=article&ID=22159&Member='
  
  def self.scan(i, l)
  	until i == l do
	    target = Nokogiri::HTML(open(@url + i.to_s))
	    if target.at_css('#ProfileDetails')
	    	tagged = target.css('#ProfileDetails td').to_s #gets contents
	    	stripped = tagged.strip #no more whites
	    	trimmed = stripped.sub(/Languages(.|\s)*/, '') #should trim everything after key
	    	fin = trimmed.gsub(/<\/?[^>]+>/, '')
	    	Stash.new do |s|
	    		puts 'Email: ' + get_email(fin)
	    		s.email = get_email(fin)
	    		puts fin
	    		s.body = fin.squish
	    		s.save!
	    	end
	    else
	    	puts 'No profile found at record no. ' + i.to_s
	    end
	    i += 1
	  end
  end

  def self.get_email(string)
  	string.scan(/\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b/i).to_s
  end

end