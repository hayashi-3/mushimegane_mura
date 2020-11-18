Rails.application.routes.draw do
  devise_for :organizers, controllers: {
    sessions: 'organizers/sessions'
  }

  devise_scope :organizer do
    post 'organizers/guest_sign_in', to: 'organizers/sessions#new_guest'
  end

  devise_for :participants, controllers: {
    registrations: 'participants/registrations',
    sessions: 'participants/sessions'
  }

  devise_scope :participant do
    post 'participants/guest_sign_in', to: 'participants/sessions#new_guest'
    get '/contract' => 'participants/registrations#contract'
  end

  namespace :organizers do
    root 'homes#top'
    resources :participants, only: [:index, :show, :edit, :update] do
      resources :infos, only: [:show, :new, :create]
      post '/back' => 'infos#back'
      post '/confirm' => 'infos#confirm'
    end
    get '/infos' => 'infos#index'
    resources :events do
      resources :reservations, only: [:index, :destroy]
    end
    resources :event_comments
  end

  scope module: :public do
    root 'homes#about'

    resources :events do
      resources :reservations, only: [:new, :create]
      resources :event_comments, only: [:create, :destroy]
    end
    
    resources :participants, only: [:show, :edit, :update] do
      resources :reservations, only: [:index, :destroy]
    end
    
    get '/participants/:id/withdrawal' => 'participants#withdrawal', as: 'participants_withdrawal'
    put '/participants/:id/unsubscribe' => 'participants#unsubscribe', as: 'participants_unsubscribe'
    get '/owabi' => 'homes#owabi'
    get '/thanks' => 'homes#thanks'
    get '/search' => 'searches#search'
  end

end