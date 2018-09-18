# frozen_string_literal: true

Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'

  resources :categories

  resources :clients do
    get :search, on: :collection
  end

  resources :custom_attributes

  resources :file_imports, only: :create

  resources :inventories, except: [:update] do
    patch :lock, on: :member
    put :lock, on: :member
  end
  get 'inventory_variants/:inventory_id/:variant_id', to: 'inventory_variants#by_variant'
  resources :inventory_variants

  resources :manufacturers do
    get :search, on: :collection
  end

  resources :orders do
    get :search, on: :collection
  end

  resources :payment_types

  resources :products

  resources :providers do
    get :search, on: :collection
  end

  resources :sales, except: %i[update]

  resources :shippings, except: [:update] do
    patch :lock, on: :member
    put :lock, on: :member
  end
  get 'shipping_variants/:shipping_id/:variant_id', to: 'shipping_variants#by_variant'
  resources :shipping_variants

  resources :stock_backup_variants, only: %i[index show]
  resources :stock_backups, only: %i[index show]

  resources :store_memberships
  resources :stores

  resources :variant_attributes
  resources :variants do
    get :by_barcode, on: :member
    get :search, on: :collection
  end

  resources :vat_rates, only: %i[index show]
end
