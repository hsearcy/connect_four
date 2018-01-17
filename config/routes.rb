Rails.application.routes.draw do
  root to: 'game#index'
  get 'game/new', to: 'game#new'
  post 'game/move', to: 'game#move'
end
