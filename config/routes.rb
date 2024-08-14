Rails.application.routes.draw do

  devise_for :users

  root 'quizzes#index'
  resources :quizzes
 
  devise_scope :user do
    get 'sign_in', to: 'devise/sessions#new'
    get 'sign_out', to: 'devise/sessions#destroy'
  end

  resources :quizzes do
    resources :questions, shallow: true
    resources :quiz_comments, only: [:create]
    get 'start', to: 'quiz_scores#start'
    post 'submit', to: 'quiz_scores#submit'
    get 'leaderboard', to: 'quizzes#leaderboard'
  end
  
  get 'leaderboard', to: 'quizzes#leaderboard'

  resources :user do
    resources :quizzes, shallow: true
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html


  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
