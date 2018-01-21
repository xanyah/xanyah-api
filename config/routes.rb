Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'

  resources :categories, except: [:destroy]

  resources :manufacturers, except: [:destroy]

  resources :providers, except: [:destroy]

  resources :store_memberships
  resources :stores, except: [:destroy]
end
