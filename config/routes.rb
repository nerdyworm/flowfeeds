Flowfeeds::Application.routes.draw do
  devise_for :admins
  devise_for :users, controllers: { sessions: 'sessions' }, skip: [:sessions]
  devise_scope :user do
    post '/sessions'   => 'sessions#create'
    delete '/sessions' => 'sessions#destroy'
  end

  concern :has_many_tracks do
    resources :tracks, only: [:index]
  end

  resources :feeds, only: [:index, :show], concerns: :has_many_tracks do
    member do
      post "played"
    end
  end

  resources :genres, only: [:index], concerns: :has_many_tracks do
    resources :feeds,  only: [:index]
    member do
      post "played"
    end
  end
  resources :listens, only: [:create]
  resources :plays, only: [:create]
  resources :playlists, only: [:index, :create, :destroy] do
    resources :playlist_items, only: [:index] do
      collection do
        post :order
      end
    end
    member do
      post :add
      post :remove
    end
  end
  resources :playlist_items, only: [:destroy]

  resources :tracks, only: [:index, :show] do
    collection do
      get :unplayed_count
    end
  end
  resources :videos, only: [:index]
  resources :watches, only: [:create]
  resources :registrations, only: [:create]

  namespace :admin do
    resources :artists do
      collection do
        get 'autocomplete'
      end
    end
    resources :feeds do
      member do
        post :enqueue_updater
      end
    end
    resources :tracks
    resources :videos
    authenticate :admin do
      mount Resque::Server, at: "resque"
    end
    root to: 'welcome#index'
  end

  namespace :api do
    resources :videos, only: [:create]
  end

  root to: 'welcome#index'
end
