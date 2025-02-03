# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  namespace :api do
    namespace :v1 do
      post '/sign_in', to: 'authentication#create'
      post '/sign_up', to: 'registration#create'

      # cohort
      get '/cla_cohorts', to: 'cla_cohorts#index'
      get '/cla_cohorts/:id', to: 'cla_cohorts#show'
      post '/cla_cohorts/new', to: 'cla_cohorts#create'
      patch '/cla_cohorts/:id', to: 'cla_cohorts#update'
    end
  end

  # Defines the root path route ("/")
  # root "posts#index"
end
