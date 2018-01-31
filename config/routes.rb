Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  
  resources :categories, except: [:destroy]
  
  resources :custom_attributes
  
  resources :inventories, except: [:destroy, :update] do
    patch :lock, on: :member
    put :lock, on: :member
  end
  resources :inventory_variants
  
  resources :manufacturers, except: [:destroy]
  
  resources :products, except: [:destroy]
  
  resources :providers, except: [:destroy]
  
  resources :store_memberships
  resources :stores, except: [:destroy]
  
  resources :variant_attributes
  resources :variants, except: [:destroy]
end
