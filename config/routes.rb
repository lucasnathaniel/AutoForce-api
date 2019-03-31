Rails.application.routes.draw do

  resources :orders do
    collection do
      get '/search/:name', to: 'orders#search' 
    end
  end

  resources :batches do
    member do
      get :summary
    end
  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
