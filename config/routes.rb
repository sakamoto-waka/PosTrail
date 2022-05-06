Rails.application.routes.draw do
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
  
  namespace :admin do
    root 'homes#top'
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
