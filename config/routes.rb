Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  root "dashboard#index"

  # Auth
  get    "/login",  to: "sessions#new",     as: :login
  post   "/login",  to: "sessions#create"
  delete "/logout", to: "sessions#destroy", as: :logout

  get "/dashboard", to: "dashboard#index", as: :dashboard

  resources :raw_materials do
    member do
      get  :add_stock
      post :add_stock
    end
  end
  resources :suppliers

  resources :production_batches do
    member do
      patch :update_status
      patch :mark_ready
    end
    resources :quality_logs, only: %i[new create]
  end

  resources :quality_logs, only: %i[index show]

  resources :inventory, only: %i[index show edit update] do
    member { post :adjust }
  end

  resources :customers
  resources :expenses

  resources :sales_orders do
    member do
      post  :collect_payment
      patch :mark_delivered
    end
  end

  # Reports
  get "/reports",                   to: "reports#index",            as: :reports
  get "/reports/daily-production",  to: "reports#daily_production", as: :report_daily_production
  get "/reports/daily-sales",       to: "reports#daily_sales",      as: :report_daily_sales
  get "/reports/inventory",         to: "reports#inventory_report", as: :report_inventory
  get "/reports/customer-credit",   to: "reports#customer_credit",  as: :report_customer_credit
  get "/reports/backup",            to: "reports#backup",           as: :report_backup

  # Settings
  get    "/settings",                 to: "settings#index",          as: :settings
  get    "/settings/new-user",        to: "settings#new_user",       as: :new_user_setting
  post   "/settings/users",           to: "settings#create_user",    as: :create_user_setting
  delete "/settings/users/:id",       to: "settings#destroy_user",   as: :destroy_user_setting
  post   "/settings/change-password", to: "settings#change_password",as: :change_password_setting
end
