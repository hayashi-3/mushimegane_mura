Rails.application.routes.draw do
  devise_for :participants
  devise_for :organizers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
