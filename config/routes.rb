Rails.application.routes.draw do

  resources :orders do
    collection do
      get '/search/reference/:reference', to: 'orders#search_reference'
      get '/search/client_name/:client_name', to: 'orders#search_name'
      get '/search/purchase_channel/:purchase_channel', to: 'orders#search_purchase_channel'
    end
  end

  resources :batches do
    collection do
      get '/produce/reference/:reference', to: 'batches#produce'
    end
  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
