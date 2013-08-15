class Stash < ActiveRecord::Base
  attr_accessible :name, :practice, :email, :phone, :body 

  def self.fight
    a = Mechanize.new { |agent|
      agent.user_agent_alias = 'Mac Safari'
    }
    a.get('http://advant.com.au/') do |home_page|
      target = home_page.elements_with(:id => 'mainbottom')
      target.images.each do |link|
        puts images.url
      end
    end
  end

end