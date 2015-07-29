Rails.application.routes.draw do
  root 'static_pages#root'
  resources :evaluations, defaults: { format: :json }, only: [:create]
end
