# frozen_string_literal: true

Rails.application.routes.draw do
  resources :shipping_variants
  mount_devise_token_auth_for 'User', at: 'auth'

  resources :categories, except: [:destroy]

  resources :custom_attributes

  resources :inventories, except: [:update] do
    patch :lock, on: :member
    put :lock, on: :member
  end
  resources :inventory_variants

  resources :manufacturers, except: [:destroy]

  resources :products, except: [:destroy]

  resources :providers, except: [:destroy]

  resources :shippings, except: [:update] do
    patch :lock, on: :member
    put :lock, on: :member
  end

  resources :stock_backup_variants, only: %i[index show]
  resources :stock_backups, only: %i[index show]

  resources :store_memberships
  resources :stores, except: [:destroy]

  resources :variant_attributes
  resources :variants, except: [:destroy]
end
