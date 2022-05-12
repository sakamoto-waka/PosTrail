Rails.application.routes.draw do

  devise_for :users, skip: :passwords, controllers: {
    registrations: 'public/registrations',
    sessions: 'public/sessions'
  }
  devise_scope :public do
    post 'public/guest_sign_in', to: 'public/sessions#guest_sign_in'
  
  devise_for :admin, skip: %w[registrations passwords], controllers: {
    sessions: 'admin/sessions'
  }

  scope module: :public do
    root 'homes#top'
    get 'about' => 'homes#about'
    resources :users, only: %w[index show edit update] do
      resource :relationships, only: %w[create destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
      member do
        get :likes
      end
    end
    resources :posts do
      resources :comments, only: %w[create destroy]
      resource :likes, only: %w[create destroy]
    end

    resources :tags, only: %w[index destroy]
    resources :notifications, only: :index
    resources :activities, only: :index
    get 'search' => 'searches#search'
  end

  namespace :admin do
    root 'homes#top' #usersのindex代わり
    resources :users, only: %w[show edit update destroy]
    resources :posts, only: %w[index show destroy] do
      collection do
        get 'tags_index' => 'posts#tags_index'
      end
      member do
        delete 'tags_index_destroy' => 'posts#tags_list_destroy'
      end
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
