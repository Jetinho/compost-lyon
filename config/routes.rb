include ApplicationHelper
Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :users, path: 'membre', controllers: { sessions: 'users/sessions'  }, path_names: {
    sign_in: devise_path_name(:sign_in),
    sign_out: devise_path_name(:sign_out),
    sign_up: devise_path_name(:sign_up)
  }
  get page_path_name(:about), to: 'pages#about', as: 'about'
  match "/404", to: "errors#not_found", via: :all
  match "/422", to: "errors#unacceptable", via: :all
  match "/500", to: "errors#internal_server_error", via: :all
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope(path_names: { new: action_path_name('new'), edit: action_path_name('edit'), search: action_path_name('search') }) do
    resources :organisations, path: resource_path_name(:organisations)
    resources :condominium_sites, path: resource_path_name(:condominium_sites), only: :index
    resources :sites, path: resource_path_name(:sites) do
      collection do
        get 'search'
      end
    end
  end
end
