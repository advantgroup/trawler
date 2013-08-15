class Stash < ActiveRecord::Base
  attr_accessible :name, :practice, :email, :phone, :body 

  def self.fight(url)
    target = Nokogiri::HTML(open(url)) do |config|
      config.noblanks
    end
    targeted = target.css('#mainbottom span')
    puts targeted
  end

end