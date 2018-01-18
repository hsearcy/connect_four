Rails.application.routes.draw do
  root to: 'game#index'
  post 'game/new', to: 'game#new'
  post 'game/move', to: 'game#move'
end
