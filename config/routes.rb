Rails.application.routes.draw do
  resources :games
  resources :games
  root 'welcome#index'

  resources :letters

  resources :games do
    resources :players do
      resources :word
    end
  end
end
