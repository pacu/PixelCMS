PixelCMS::Application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  root to: 'admin/dashboard#index'

  resources :publishers do
    resources :publications do
      resources :issues
    end

  end

#  match 'publishers/:publisher_name/:publication_name/ '
end
