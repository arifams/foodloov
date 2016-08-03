Rails.application.routes.draw do
	resources :recipes
	root "index#recipes"
end
