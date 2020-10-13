Rails.application.routes.draw do
  devise_for :organizers, controllers: {
    sessions: 'organizers/sessions'
  }

  devise_for :participants, controllers: {
    registrations: 'participants/registrations',
    sessions: 'participants/sessions'
  }

  namespace :organizers do
    resources :participants do
      resources :infos, only: [:index, :new, :create]
    end
    resources :events do
      resources :reservations, only: [:index]
    end
  end

  scope module: :public do
    root 'events#index'
    get 'about' => 'homes#about'

    resources :events do
      resources :reservations, only: [:new, :create]
      resource :event_comments, only: [:create, :destroy]
    end
    
    resources :participants, only: [:show, :edit, :update] do
      resources :reservations, only: [:index]
    end
    
    get '/participants/:id/withdrawal' => 'participants#withdrawal', as: 'participants_withdrawal'
    put '/participants/:id/unsubscribe' => 'participants#unsubscribe', as: 'participants_unsubscribe'
    get '/see_you' => 'homes#see_you'
    get '/thanks' => 'homes#thanks'
  end

end
