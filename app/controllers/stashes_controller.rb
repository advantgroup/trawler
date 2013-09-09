class StashesController < ActionController::Base

  def index
		@stashes = Stash.all
	  respond_to do |format|
	    format.html
	    format.csv { send_data Stash.to_csv }
	  end
  end

end
