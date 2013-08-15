class Stash < ActiveRecord::Base
  attr_accessible :name, :practice, :email, :phone, :body 

  @url = 'http://www.fpa.com.au/default.asp?action=article&ID=22159&Member='

  def self.scan(i, l)
  	until i == l do
	    target = Nokogiri::HTML(open(@url + i.to_s)) do |config|
	      config.noblanks
	    end
	    if target.at_css('#ProfileDetails')
	    	targeted = target.css('#ProfileDetails td')
	    	puts targeted
	    else
	    	puts 'No profile found at record no. ' + i.to_s
	    end
	    i += 1
	  end
  end

end