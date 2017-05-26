Rails.application.routes.draw do
  mount ActionCable.server, at: '/cable'
  mount Attachinary::Engine => "/attachinary"

  devise_for :users
  scope '(:locale)', locale: /fr/ do
    root to: 'pages#home'
    resources :searches, only: [:index, :show, :new, :create, :destroy], shallow: true
    require "sidekiq/web"
    authenticate :user, lambda { |u| u.admin } do
      mount Sidekiq::Web => '/sidekiq'
    end
  end
  get '/demo' => 'pages#demo'
end
