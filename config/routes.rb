Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/', to: 'merchants#index'
        post '/', to: 'merchants#create'
        resources :most_revenue, only: [:index]
        get '/:id', to: 'merchants#show'
      end
    end
  end
end
