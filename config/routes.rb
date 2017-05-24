Rails.application.routes.draw do
  mount Attachinary::Engine => "/attachinary"
  devise_for :users
  root to: 'pages#home'
  resources :searches, only: [:index, :show, :new, :create, :destroy], shallow: true
end
