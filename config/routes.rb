Trawler::Application.routes.draw do

  resources :stashes, :only => [:index]
  root :to => 'stashes#index'

end
