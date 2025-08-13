# frozen_string_literal: true
require 'rswag/api'
require 'rswag/ui'

Rails.application.routes.draw do
  mount Rswag::Api::Engine => '/api-docs'
  mount Rswag::Ui::Engine => '/api-docs'
  get '/openapi.json', to: 'swagger#index'
  get '/openapi.yaml', to: 'swagger#index'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  namespace :api do
    namespace :v1 do
      post '/sign_in', to: 'authentication#create'
      post '/sign_up', to: 'registration#create'
      put '/edit_profile', to: 'registration#update'
      post '/forgot_password', to: 'passwords#forgot_password'
      post '/reset_password', to: 'passwords#reset_password'

      resource :cla_dashboards do
        get :course_stats
        get :score_stats
        get :assignment_stats
        get :attendance_stats
        get :desk_stats
        get :student_list
        get :student_details
        get :student_dashboard_stats
      end
      resources :cla_users
      resources :cla_roles
      resources :cla_cohorts
      resources :cla_courses do
        collection do
          get :get_course_ids
        end
      end
      resources :cla_topics
      resources :cla_assignments
      resources :cla_submissions do
        collection do
          get :students_without_scores
        end
      end
      resources :cla_live_classes do
        collection do
          get :today_classes
        end
      end
      resources :cla_attendances do
        collection do
          get :missing_attendance
        end
      end
      resources :cla_cbts
      resources :cla_cbts_scores do
        collection do
          get :students_without_scores
        end
      end
      resources :cla_contributions
      resources :cla_contributions_scores do
        collection do
          get :students_without_scores
        end
      end
      resources :cla_announcements
    end
  end

  # Defines the root path route ("/")
  # root "posts#index"
end
