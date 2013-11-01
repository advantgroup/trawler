class Stash < ActiveRecord::Base
  attr_accessible :name, :practice, :address, :phone, :fax, :email, :body

  # column_names = :name, :practice, :address, :phone, :fax, :email

  def self.xero_scan(i, limit)
  	# @url = 'http://www.xero.com/au/advisors/?country=au&service=accountant&p='
  	@url = 'http://advant.com.au/test.html'
  	until i == limit do # pages
	    # target = Nokogiri::HTML(open(@url + i.to_s, 'User-Agent' => 'Mozilla/5.0'))
	    target = Nokogiri::HTML(open(@url, 'User-Agent' => 'Mozilla/5.0'))
	    target.css('article.row').children.each do |entry| #entires on each page
	    	puts entry.css('h2').to_s.strip.gsub(/<\/?[^>]+>/, '').squish
	    	entry.css('a').each do |anchor|
	    		puts anchor.text if anchor.text.match(/@/)
	    	end
	    	puts entry.css('.address span').to_s.strip.gsub(/<\/?[^>]+>/, '').squish
	    end
	    i += 1
	  end
  end

  def clean(element)
	  element.to_s.strip.gsub(/<\/?[^>]+>/, '').squish
  end
  
  def self.fpa_scan(i, limit)
  	@url = 'http://www.xero.com/au/advisors/?country=au&service=accountant&p='
  	until i == limit do
	    target = Nokogiri::HTML(open(@url + i.to_s, 'User-Agent' => 'Mozilla/5.0'))
	    if target.at_css('#ProfileDetails')
	    	@adviser = []
	    	target.css('#ProfileDetails tr').each_with_index do |row, number|
	    		unless number > 6 # trims everything after email
	    			stringed = row.to_s
	    			stripped = stringed.strip # no more whites
	    			subbed = stripped.gsub(/<\/?[^>]+>/, '') # tags out
	    			squished = subbed.squish # no more returns
	    			@adviser.push(squished)
					end
	    	end
	    	Stash.new do |s|
	    		s.name = @adviser[0].to_s
	    		s.practice = @adviser[1].to_s
	    		s.address = @adviser[2].to_s
	    		s.phone = @adviser[3].to_s + ' ' + @adviser[5].to_s
	    		s.fax = @adviser[4].to_s
	    		s.email = @adviser[6].to_s
	    		s.body = @adviser.to_s
	    		s.save!
	    	end
	    else
	    	puts 'No profile found at record no. ' + i.to_s
	    end
	    i += 1
	    sleep(rand(2.001..3.999)) # under the radar
	  end
	rescue Timeout::Error
  	puts 'Timing out...'
  	sleep(rand(8.001..12.999))
		scan(i, limit)
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |stash|
        csv << stash.attributes.values_at(*column_names)
      end
    end
  end

end