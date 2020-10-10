Rails.application.routes.draw do
  devise_for :organizers, controllers: {
    sessions: 'organizers/sessions'
  }

  devise_for :participants, controllers: {
    registrations: 'participants/registrations',
    sessions: 'participants/sessions'
  }

  namespace :organizers do
    resources :events, :participants, :reservations
    get 'info' => 'infos#index'
    get 'info/new' => 'infos#new'
    put 'info' => 'infos#create'
  end

  scope module: :public do
    root 'events#index'
    get 'about' => 'homes#about'
    resources :events do
      resources :reservations, only: [:new, :create]
    end
    resources :participants, only: [:show, :edit, :update]
    get '/participants/:id/withdrawal' => 'participants#withdrawal'
    put '/participants/:id/unsubscribe' => 'participants#unsubscribe'
    get '/see_you' => 'homes#see_you'
    get '/thanks' => 'homes#thanks'
  end

end
