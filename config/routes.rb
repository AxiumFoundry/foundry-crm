Rails.application.routes.draw do
  root "pages#home"

  resource :session, only: [ :new, :create, :destroy ]
  get "login", to: "sessions#new", as: :login

  namespace :admin do
    root to: "dashboards#show"

    resources :case_studies
    resources :chat_conversations, only: [ :index, :show ]
    resources :knowledge_documents, except: [ :show ]

    resource :site_setting, only: [ :edit, :update ]

    resources :contacts
    resources :health_check_submissions, only: [ :index, :show ]
    resources :projects
    resources :milestones, only: [ :create, :update, :destroy ]
    resources :milestone_completions, only: [ :create, :destroy ]

    resources :time_entries, only: [ :index, :new, :create, :edit, :update, :destroy ]

    resources :invoices
    resources :invoice_pdfs, only: [ :show ]
    resources :invoice_sendings, only: [ :create ]
    resources :invoice_payments, only: [ :create ]
  end

  resources :chat_messages, only: [ :create ]
  resources :chat_human_requests, only: [ :create ]

  resources :case_studies, only: [ :index, :show ]
  resources :health_checks, only: [ :new, :create ]
  # Capability pages
  get "capabilities/ship-faster", to: "capabilities#ship_faster", as: :ship_faster
  get "capabilities/rescue-modernize", to: "capabilities#rescue_modernize", as: :rescue_modernize
  get "capabilities/deploy-scale", to: "capabilities#deploy_scale", as: :deploy_scale
  get "capabilities/integrate-extend", to: "capabilities#integrate_extend", as: :integrate_extend
  get "capabilities/ai-agents", to: "capabilities#ai_agents", as: :ai_agents

  # Product pages
  get "products/foundry-crm", to: "products#foundry_crm", as: :foundry_crm

  # About page
  get "about", to: "pages#about", as: :about

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
end
