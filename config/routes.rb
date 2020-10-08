Rails.application.routes.draw do
  devise_for :organizers, controllers: {
    sessions: 'organizers/sessions'
  }

  devise_for :participants, controllers: {
    registrations: 'participants/registrations',
    sessions: 'participants/sessions'
  }

  namespace :organizers do
    root "events#index"
    resources :events, :participants, :reservations
  end

  scope module: :public do
    root 'events#index'
    get 'about' => 'homes#about'
    resources :events do
      resource :reservation, only: [:edit, :update]
    end
    resources :participants, only: [:show, :edit, :update]
  end

end
