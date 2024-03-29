include ApplicationHelper
Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount LetterOpenerWeb::Engine, at: "/letter_opener" unless Rails.env.production? || Rails.env.test?

  root to: 'pages#home'
  get 'composteurs-collectifs/', to: redirect('/composteurs-collectifs-de-quartier')
  get 'composteurs-collectifs/:site_name', to: redirect('/composteurs-collectifs-de-quartier/%{site_name}')
  get 'composteurs-de-copropriete/', to: redirect('/composteurs-collectifs-de-copropriete')
  get 'acteurs/', to: redirect('/compostage-collectif/acteurs')

  # site specific redirections
  get 'composteurs-collectifs-de-quartier/les-coccinelles-de-sans-souci', to: redirect('/composteurs-collectifs-de-quartier/composteur-les-coccinelles-de-sans-souci')
  get 'composteurs-collectifs-de-quartier/composteur-tuba-composteur', to: redirect('/composteurs-collectifs-de-quartier/composteur-tuba-composte')

  # Sitemaps
  get '/sitemap.xml.gz', to: redirect("http://#{ENV['S3_BUCKET_NAME']}.s3.eu-west-3.amazonaws.com/sitemaps/sitemap.xml.gz")
  get '/sitemap1.xml.gz', to: redirect("http://#{ENV['S3_BUCKET_NAME']}.s3.eu-west-3.amazonaws.com/sitemaps/sitemap1.xml.gz")

  get page_path_name(:about), to: 'pages#about', as: 'about'
  get page_path_name(:collective_composting), to: 'pages#collective_composting', as: 'collective_composting'
  match "/404", to: "errors#not_found", via: :all
  match "/422", to: "errors#unacceptable", via: :all
  match "/500", to: "errors#internal_server_error", via: :all
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope(path_names: { new: action_path_name('new'), edit: action_path_name('edit'), search: action_path_name('search') }) do
    devise_for :users, path: 'membre',
    controllers: { sessions: 'users/sessions', registrations: 'users/registrations', passwords: 'users/passwords' },
    path_names: {
      sign_in: devise_path_name(:sign_in),
      sign_out: devise_path_name(:sign_out),
      sign_up: devise_path_name(:sign_up),
      password:  devise_path_name(:password)
    }

    resources :organisations, path: resource_path_name(:organisations), except: :destroy
    resources :condominium_sites, except: :destroy, path: resource_path_name(:condominium_sites)
    resources :sites, except: :destroy, path: resource_path_name(:district_composting_sites), controller: 'district_composting_sites' do
      collection do
        get 'search'
      end
    end
  end
end
