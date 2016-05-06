require 'sidekiq/web'
Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  resources :states, except: [:new, :edit]

  resources :bugs, except: [:new, :edit], param: :number do
    resources :states, except: [:new, :edit]
    collection do
      get 'count'
    end
  end
end
