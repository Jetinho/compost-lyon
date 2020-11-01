Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope(path_names: { new: 'creation', edit: 'edition', search: 'rechercher' }) do
    resources :sites, path: 'composteurs-collectifs' do
      collection do
        get 'search'#, as: 'sites/search'
      end
    end
  end
end
