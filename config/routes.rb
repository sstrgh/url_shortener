Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'short_urls#new'

  get '/new' => 'short_urls#new'
  get '/:short_url', to: 'short_urls#show'
  post '/short_urls' => 'short_urls#create'

end
