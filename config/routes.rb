Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    resources :users, only: [:show] do 
        resources :posts, only: [:new]
    end 

    resources :users, only: [:new, :create, :destroy]
    resources :posts, only: [:create, :update, :destroy, :show, :edit]
    resource :session, only: [:new, :create, :destroy]
    resource :home, only: [:show]
end
