Rails.application.routes.draw do
  resources :states, except: [:new, :edit]
  resources :bugs, except: [:new, :edit], param: :number do
    resources :states, except: [:new, :edit]
    collection do
      get 'count'
    end
  end
end
