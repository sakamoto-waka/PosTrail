Rails.application.routes.draw do
  devise_for :users, skip: :passwords, controllers: {
    registrations: 'public/registrations',
    sessions: 'public/sessions',
  }
  devise_scope :user do
    post 'guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  devise_for :admin, skip: %w(registrations passwords), controllers: {
    sessions: 'admin/sessions',
  }

  scope module: :public do
    root 'homes#top'
    get 'about' => 'homes#about'
    resources :users, only: %w(index show edit update) do
      resource :relationships, only: %w(create destroy)
      get 'followings' => 'relationships#followings', as: 'followings'
      member do
        get :likes
      end
    end
    resources :posts do
      resources :comments, only: %w(create destroy)
      resource :likes, only: %w(create destroy)
    end
    resources :tags, only: %w(index destroy)
    resources :notifications, only: :index
    resources :activities, only: :index
    get 'search' => 'searches#search'
    resources :questions, only: %w(index new create)
    resources :chats, only: %w(show create)
  end

  namespace :admin do
    root 'homes#top' # usersのindex代わり
    resources :users, only: %w(show edit update destroy)
    resources :posts, only: %w(index show destroy) do
      resources :comments, only: :destroy
      collection do
        get 'tags_index' => 'posts#tags_index'
      end
      member do
        delete 'tags_index_destroy' => 'posts#tags_index_destroy'
      end
    end
    resources :questions, except: %w(new create)
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
