Rails.application.routes.draw do

  devise_for :accounts, controllers: {
    sessions: 'account/sessions',
    passwords: 'account/passwords',
    confirmations: 'account/confirmations',
  }, only: [:sessions, :passwords, :confirmations]

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'

  root to: 'main#home'

  namespace :account do
    root to: 'main#dashboard', as: :root
    resources :account_ssh_keys, path: 'ssh_keys', only: [:index, :create, :destroy]
  end

end
