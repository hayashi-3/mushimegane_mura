Rails.application.routes.draw do
  devise_for :organizers, controllers: {
    sessions: 'organizers/sessions'
  }

  devise_for :participants, controllers: {
    registrations: 'participants/registrations',
    sessions: 'participants/sessions'
  }

  devise_scope :participant do
    post 'participants/guest_sign_in', to: 'participants/sessions#new_guest'
  end

  namespace :organizers do
    root 'homes#top'
    resources :participants, only: [:index, :show, :edit, :update] do
      resources :infos, only: [:index, :new, :create]
    end
    resources :events do
      resources :reservations, only: [:index, :destroy]
    end
  end

  scope module: :public do
    root 'homes#about'

    resources :events do
      resources :reservations, only: [:new, :create]
      resource :event_comments, only: [:create, :destroy]
    end
    
    resources :participants, only: [:show, :edit, :update] do
      resources :reservations, only: [:index, :destroy]
    end
    
    get '/participants/:id/withdrawal' => 'participants#withdrawal', as: 'participants_withdrawal'
    put '/participants/:id/unsubscribe' => 'participants#unsubscribe', as: 'participants_unsubscribe'
    get '/owabi' => 'homes#owabi'
    get '/thanks' => 'homes#thanks'
  end

end