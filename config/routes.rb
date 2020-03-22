Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      namespace :merchants do
        resources :most_revenue, only: [:index]
        resources :most_items, only: [:index]
        get '/find_all', to: 'search#index'
        get '/find', to: 'search#show'
        get '/', to: 'merchants#index'
        post '/', to: 'merchants#create'
        get '/:id', to: 'merchants#show'
        patch '/:id', to: 'merchants#update'
        delete '/:id', to: 'merchants#destroy'
        get '/:merchant_id/items', to: 'items#index'
      end

      namespace :items do
        get '/find_all', to: 'search#index'
        get '/find', to: 'search#show'
        get '/', to: 'items#index'
        post '/', to: 'items#create'
        get '/:id', to: 'items#show'
        patch '/:id', to: 'items#update'
        delete '/:id', to: 'items#destroy'
        get '/:item_id/merchant', to: 'merchant#show'
      end

      namespace :revenue do
        get '/', to: 'revenue#show'
      end
    end
  end
end
