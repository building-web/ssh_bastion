Rails.application.routes.draw do

  devise_for :accounts, controllers: {
    sessions: 'account/sessions',
    passwords: 'account/passwords'
  }, only: [:sessions, :passwords]

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'

end
