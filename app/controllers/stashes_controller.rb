class StashesController < ActionController::Base

  def index
		@stashes = Stash.all
	  respond_to do |format|
	    format.html
	    format.json { render json: @stash }
	    format.csv
	  end
  end

end
