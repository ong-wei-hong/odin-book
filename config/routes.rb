Rails.application.routes.draw do
	authenticated :user do
    root 'posts#index', as: :authenticated_root
  end

  devise_scope :user do
    root 'users/sessions#new'
  end

	devise_for :users, controllers: {
		sessions: 'users/sessions',
		registrations: 'users/registrations',
		omniauth_callbacks: 'users/omniauth_callbacks'
	}

	resources :users, only: [:show, :update]
	get 'search', to: 'users#search'
	get 'notifications', to: 'users#notification'

	resource :friend_requests, only: :create
	resource :friends, only: :create
	resource :posts, only: [:index, :create, :new]
	resource :likes, only: :create
	resource :comments, only: :create
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
