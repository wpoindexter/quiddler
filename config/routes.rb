Rails.application.routes.draw do
  root 'welcome#index'

  resources :letters

  resources :games do
    resources :players do
      resources :words
    end
  end

  post '/words/validate' => 'words#validate'
end
