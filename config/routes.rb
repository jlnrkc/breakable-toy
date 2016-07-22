Rails.application.routes.draw do
  devise_scope :user do
    root to: "devise/registrations#new"
  end
  devise_for :users
  resources :pets, only: [:index, :search, :show]
end
