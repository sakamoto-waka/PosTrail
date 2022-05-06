Rails.application.routes.draw do
  namespace :public do
    get 'activities/index'
  end
  namespace :public do
    get 'notifications/index'
  end
  namespace :public do
    get 'posts/index'
    get 'posts/new'
    get 'posts/show'
    get 'posts/edit'
  end
  namespace :public do
    get 'users/index'
    get 'users/show'
    get 'users/edit'
  end
  namespace :admin do
    get 'posts/index'
    get 'posts/show'
  end
  namespace :admin do
    get 'users/show'
    get 'users/edit'
  end
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
  end
  
  namespace :adimin do
    root 'homes#top' #usersのindex代わり
    resources :users, only: [:show, :edit, :destroy]
    resources :posts, only: [:index, :show, :destroy]
    resources :comments, only: [:destroy]
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
