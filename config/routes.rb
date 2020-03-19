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
      end
      
      namespace :items do
        get '/', to: 'items#index'
      end
    end
  end
end
