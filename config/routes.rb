Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.tml
  root to: "accounts#index"

  resources :accounts, only: [:index, :show] do
    resources :fetch_threads, controller: "accounts/fetch_threads", only: :index
    resources :threads, controller: "accounts/threads"
  end

  get "auth/google_oauth2/callback" => "account_tokens#update"
  get "auth/failure" => "account_tokens#failure"
end
