require 'sidekiq/web'
Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  resources :bugs, except: [:new, :edit, :update, :delete], param: :number do
    collection do
      get 'count'
    end
  end
end
