Rails.application.routes.draw do

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: 'admin/sessions',
  }

  namespace :admin do
    get '/' => 'homes#top'
    get 'search' => 'homes#search', as: 'search'
    resources :customers, only: [:index, :show, :edit, :update]
    resources :items, only: [:index, :new, :create, :show, :edit, :update] #except: [:destroy]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :reviews, only: [:show, :destroy]
    resources :comments, only: [:index, :destroy]
  end


  devise_for :customers, skip: [:passwords,] ,controllers: {
    sessions: 'public/sessions',
    registrations: 'public/registrations',
  }

  scope module: :public do
    root to: 'homes#top'
    get 'about' => 'homes#about', as: 'about'
    #get 'search' => 'homes#search', as: 'search'
    get 'customers/information' => 'customers#show'
    get 'customers/information/edit' => 'customers#edit'
    patch 'customers/information' => 'customers#update'
    get 'customers/confirm_withdraw' => 'customers#confirm_withdraw'
    patch 'customers/withdraw' => 'customers#withdraw'
    get 'notices' => 'notices#index'
    resources :mybike_reviews, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
      resources :comments, only: [:create]
    end
    resources :bike_reviews, only: [:index, :show] do
      resources :comments, only: [:create]
    end
    get 'search' => 'bike_reviews#search', as: 'search'
  end
end
