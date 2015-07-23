Rails.application.routes.draw do
  root 'welcome#index'

  namespace :api do
    namespace :v1 do
      resources :letters
      resources :games do
        resources :players do
          resources :words
        end
      end
      post '/words/validate' => 'words#validate'
    end
  end

  namespace :admin do
    get '/dashboard' => 'admin#dashboard'
  end
end
