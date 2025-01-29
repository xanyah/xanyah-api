# frozen_string_literal: true

Rails.application.routes.draw do
  use_doorkeeper
  default_url_options host: ENV.fetch('RAILS_DEFAULT_HOST', 'localhost:3000')

  resources :categories

  resources :customers do
    # get :search, on: :collection
  end

  resources :custom_attributes

  resources :file_imports, only: :create

  resources :inventories, except: [:update] do
    patch :lock, on: :member
    put :lock, on: :member
  end

  resources :manufacturers do
    # get :search, on: :collection
  end

  resources :orders do
    # get :search, on: :collection
  end

  resources :payment_types

  resources :products

  resources :providers do
    # get :search, on: :collection
  end

  resources :sales, except: %i[update]

  resources :shippings, except: [:update] do
    patch :lock, on: :member
    put :lock, on: :member
  end

  resources :store_memberships
  resources :stores

  resources :vat_rates, only: %i[index show]

  namespace :v2 do
    resources :categories
    resource :current_user, controller: :current_user, except: :destroy
    resources :customers
    resources :custom_attributes
    resources :file_imports, only: :create
    resources :inventories, except: [:update] do
      patch :lock, on: :member
      put :lock, on: :member
    end
    resources :inventory_products
    resources :manufacturers
    resources :orders, except: :destroy do
      patch :cancel, on: :member
    end
    resources :payment_types
    resources :products
    resources :providers
    resources :sales, except: %i[update]
    resources :shippings, except: [:update] do
      patch :validate, on: :member
      patch :rollback, on: :member
    end
    resources :shipping_products

    resources :store_memberships
    resources :stores

    resources :products

    resources :vat_rates, only: :index
  end
end
