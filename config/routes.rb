Rails.application.routes.draw do
  	
  	devise_for :users

  	root "recipes#index"
	
	resources :recipes do
		member do
			put "like" => "recipes#upvote"
			put "unlike" => "recipes#downvote"			
		end
	end
	

end
