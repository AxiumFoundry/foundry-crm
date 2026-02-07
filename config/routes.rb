Rails.application.routes.draw do
  root "pages#home"

  resources :case_studies, only: [ :index, :show ]
  resources :health_checks, only: [ :new, :create ]

  # Capability pages
  get "capabilities/ship-faster", to: "capabilities#ship_faster", as: :ship_faster
  get "capabilities/rescue-modernize", to: "capabilities#rescue_modernize", as: :rescue_modernize
  get "capabilities/deploy-scale", to: "capabilities#deploy_scale", as: :deploy_scale
  get "capabilities/integrate-extend", to: "capabilities#integrate_extend", as: :integrate_extend
  get "capabilities/ai-agents", to: "capabilities#ai_agents", as: :ai_agents

  # About page
  get "about", to: "pages#about", as: :about

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
end
