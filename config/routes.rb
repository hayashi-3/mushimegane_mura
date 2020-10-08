Rails.application.routes.draw do
  devise_for :organizers, controllers: {
    sessions: 'organizers/sessions'
  }

  devise_for :participants, controllers: {
    registrations: 'participants/registrations',
    sessions: 'participants/sessions'
  }

end
