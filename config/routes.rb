Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get 'a-propos', to: 'pages#about', as: 'about'
  match "/404", to: "errors#not_found", via: :all
  match "/422", to: "errors#unacceptable", via: :all
  match "/500", to: "errors#internal_server_error", via: :all
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope(path_names: { new: 'creation', edit: 'edition', search: 'rechercher' }) do
    resources :organisations, path: 'acteurs', only: :show
    resources :condominium_sites, path: 'composteurs-de-copropriete', only: :index
    resources :sites, path: 'composteurs-collectifs' do
      collection do
        get 'search'#, as: 'sites/search'
      end
    end
  end
end
