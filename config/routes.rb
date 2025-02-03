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
      delete '/cla_cohorts/:id', to: 'cla_cohorts#destroy'

      # course
      get '/cla_courses', to: 'cla_courses#index'
      get '/cla_courses/:id', to: 'cla_courses#show'
      post '/cla_courses/new', to: 'cla_courses#create'
      patch '/cla_courses/:id', to: 'cla_courses#update'
      delete '/cla_courses/:id', to: 'cla_courses#destroy'

      # role
      get '/cla_roles', to: 'cla_roles#index'
      get '/cla_roles/:id', to: 'cla_roles#show'
      post '/cla_roles/new', to: 'cla_roles#create'
      patch '/cla_roles/:id', to: 'cla_roles#update'
      delete '/cla_roles/:id', to: 'cla_roles#destroy'

      # user
      get '/cla_users', to: 'cla_users#index'
      get '/cla_users/:id', to: 'cla_users#show'
      post '/cla_users/new', to: 'cla_users#create'
      patch '/cla_users/:id', to: 'cla_users#update'
      delete '/cla_users/:id', to: 'cla_users#destroy'

      # topic
      get '/cla_topics', to: 'cla_topics#index'
      get '/cla_topics/:id', to: 'cla_topics#show'
      post '/cla_topics/new', to: 'cla_topics#create'
      patch '/cla_topics/:id', to: 'cla_topics#update'
      delete '/cla_topics/:id', to: 'cla_topics#destroy'

      # assignment
      get '/cla_assignments', to: 'cla_assignments#index'
      get '/cla_assignments/:id', to: 'cla_assignments#show'
      post '/cla_assignments/new', to: 'cla_assignments#create'
      patch '/cla_assignments/:id', to: 'cla_assignments#update'
      delete '/cla_assignments/:id', to: 'cla_assignments#destroy'

      # live class
      get '/cla_live_classes', to: 'cla_live_classes#index'
      get '/cla_live_classes/:id', to: 'cla_live_classes#show'
      post '/cla_live_classes/new', to: 'cla_live_classes#create'
      patch '/cla_live_classes/:id', to: 'cla_live_classes#update'
      delete '/cla_live_classes/:id', to: 'cla_live_classes#destroy'

      # submission
      get '/cla_submissions', to: 'cla_submissions#index'
      get '/cla_submissions/:id', to: 'cla_submissions#show'
      post '/cla_submissions/new', to: 'cla_submissions#create'
      patch '/cla_submissions/:id', to: 'cla_submissions#update'
      delete '/cla_submissions/:id', to: 'cla_submissions#destroy'
    end
  end

  # Defines the root path route ("/")
  # root "posts#index"
end
