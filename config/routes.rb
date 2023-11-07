Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :attendance, only: [:index, :show, :create, :destroy]
  resources :courses, only: [:index, :show, :create, :update, :destroy]
  post '/login', to:  "users#login"
  post '/signup', to:  "users#signup"
  get ':id/course-reports', to:  "courses#course_reports"

end
