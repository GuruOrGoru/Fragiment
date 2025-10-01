Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: "users/sessions", registrations: "users/registrations" }

  namespace :admin do
    get "dashboard", to: "dashboard#index"
    resources :users do
      post "toggle_admin", on: :member
    end
    resources :snippets
  end



  resources :users, only: [ :show ], constraints: { id: /\d+/ }

    # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

    root "snippets#index"

    get "language/:language", to: "snippets#language", as: :language

     resources :snippets do
       resource :like, only: [ :create, :destroy ]
       resource :bookmark, only: [ :create, :destroy ]
       post "vote_working", to: "snippet_votes#create", defaults: { vote_type: "working" }
       post "vote_broken", to: "snippet_votes#create", defaults: { vote_type: "broken" }
       delete "unvote_snippet", to: "snippet_votes#destroy"
        resources :suggestions, only: [ :create, :destroy ] do
          post "vote_working", to: "suggestion_votes#create", defaults: { vote_type: "working" }
          post "vote_broken", to: "suggestion_votes#create", defaults: { vote_type: "broken" }
          post "vote_implemented", to: "suggestion_votes#create", defaults: { vote_type: "implemented" }
          post "vote_not_working", to: "suggestion_votes#create", defaults: { vote_type: "not_working" }
          delete "unvote", to: "suggestion_votes#destroy"
        end
     end

   resources :bookmarks, only: [ :index ]

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
end
