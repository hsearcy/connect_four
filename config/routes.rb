Rails.application.routes.draw do
  root to: 'game#index'
  get 'game/new', to: 'game#new'
end
