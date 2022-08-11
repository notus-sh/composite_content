# frozen_string_literal: true

ActionView::Base.empty
Rails.application.routes.draw do
  resources :articles
  root 'articles#index'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end
