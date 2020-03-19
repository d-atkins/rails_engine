Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      namespace :merchants do
        resources :most_revenue, only: [:index]
        get '/', to: 'merchants#index'
        post '/', to: 'merchants#create'
        get '/:id', to: 'merchants#show'
        patch '/:id', to: 'merchants#update'
        delete '/:id', to: 'merchants#destroy'
        get '/:merchant_id/items', to: 'items#index'
      end

      namespace :items do
        get '/', to: 'items#index'
        post '/', to: 'items#create'
        get '/:id', to: 'items#show'
        patch '/:id', to: 'items#update'
        delete '/:id', to: 'items#destroy'
        get '/:item_id/merchant', to: 'merchant#show'
      end
    end
  end
end
