Rails.application.routes.draw do
  devise_for :users
  resources :users, only: %i[index show] do
    resources :notes, only: [:index], path: 'blog'
  end

  resources :notes, except: [:index] do
    resources :containers, except: %i[index show]
  end

  resources :containers, only: %i[] do
    collection do
      post :sort
    end
  end

  root to: 'main#index'
end
