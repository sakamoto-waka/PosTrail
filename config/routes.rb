Rails.application.routes.draw do
  
  devise_for :users, skip: [:passwords], controllers: {
    registrations: 'public/registrations',
    sessions: 'public/sessions'
  }
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: 'admin/sessions'
  }
  
  scope module: :public do
    root 'homes#top'
    get 'about' => 'homes#about'
    resources :users, only: [:index, :show, :edit, :update] do
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
    end
    resources :posts do
      resources :comments, only: [:create, :destroy]
      resource :likes, only: [:create, :destroy]
    end
    resources :notifications, only: :index
    resources :activities, only: :index
  end
  
  namespace :admin do
    root 'homes#top' #usersのindex代わり
    resources :users, only: [:show, :edit, :destroy]
    resources :posts, only: [:index, :show, :destroy]
    resources :comments, only: [:destroy]
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
