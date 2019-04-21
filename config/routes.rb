Rails.application.routes.draw do
  root to: 'lists#index'

  resources :lists do |member|
    resources :expenses
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
