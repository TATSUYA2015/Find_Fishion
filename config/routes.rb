Rails.application.routes.draw do

  devise_for :web_admin, skip: [:registrations, :passwords] , controllers: {
  sessions: "web_admin/sessions"
  }
  namespace :web_admin do
    resources :contributors do
      resource :relationships, only: [:create, :destroy]
      #フォローしてくれている人全員を表示してくれる
      get :followers, on: :member
    end
    resources :customers do
      resource :relationships
      #ある利用者がフォローしている人全員を表示してくれる
      get :followings, on: :member
    end
    resources :items
    resources :genres
  end



  devise_for :contributor, skip: [:passwords], controllers: {
  registrations: "post_admin/registrations",
  sessions: 'post_admin/sessions'
  }
  namespace :post_admin do
    get 'homes/top'
    resources :contributors do
      resource :relationships, only: [:create, :destroy]
      #フォローしてくれている人全員を表示してくれる
      get :followers, on: :member
    end
    ##退会画面
    get 'contributors/:id/unsubscribe' => 'contributors#unsubscribe', as: 'unsubscribe'
    #論理削除用のルーティング
    patch 'contributors/:id/withdrawal' => 'contributors#withdrawal', as: 'contributors_withdrawal'
    resources :items
  end



  devise_for :customer, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions',
      # Twitter API認証用
    :omniauth_callbacks => 'public/omniauth_callbacks',
  }

  scope module: :public do
    root  'homes#top'
    get 'home/about' => 'homes#about', as: 'about'
    get "search" => "searches#search"
    resources :contributors do
      resource :relationships, only: [:create, :destroy]
      #ある利用者がフォローしている人全員を表示してくれる
      get :followings, on: :member
      #フォローしてくれている人全員を表示してくれる
      get :followers, on: :member
    end
    resources :customers do
      resource :relationships
      #ある利用者がフォローしている人全員を表示してくれる
      get :followings, on: :member
    end
    ##退会画面
    get 'customers/:id/unsubscribe' => 'customers#unsubscribe', as: 'unsubscribe'
    #論理削除用のルーティング
    patch 'customers/:id/withdrawal' => 'customers#withdrawal', as: 'customers_withdrawal'
    resources :items do
      resource :favorites, only: [:create, :destroy]
      member do
        get :favorites
      end
      resources :comments, only: [:create, :destroy]
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
