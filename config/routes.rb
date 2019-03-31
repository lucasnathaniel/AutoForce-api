Rails.application.routes.draw do

  resources :orders do
    collection do
      get '/search/reference/:reference', to: 'orders#search_reference'
      get '/search/name/:client_name', to: 'orders#search_name' 
    end
  end

  resources :batches do
    member do
      get :summary
    end
  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
