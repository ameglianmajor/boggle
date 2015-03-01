Rails.application.routes.draw do
  apipie
  root to: 'visitors#index'
  devise_for :users
  post 'visitors/determine_words'
end
