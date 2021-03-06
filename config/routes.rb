Rails.application.routes.draw do
  root to: "welcome#index"
  devise_for :users

  resources :pets, only: [:index, :show] do
    post :fave
  end
  resources :photos, only: [:new, :create, :index, :destroy]
  get :search, to: 'pets#search', as: :pets_search
  get 'welcome/about_us', to: 'welcome#about_us'
end
