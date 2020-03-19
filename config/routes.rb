Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/', to: 'merchants#index'
        resources :most_revenue, only: [:index]
      end
    end
  end
end
