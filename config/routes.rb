Rails.application.routes.draw do
  scope module: 'api' do
    namespace :v1 do
      # Resource routes (maps HTTP verbs to controller actions automatically):
      resources :owners
      resources :animals
      resources :pets
      resources :visits
      resources :dosages
      resources :treatments
      resources :medicines
      resources :procedures

      # Routes related to authentication
      resources :users
      get :token, controller: 'application'
      get :authenticate_with_token, controller: 'application'

      # Routes for mecidine and procedure costs
      get 'medicine_costs/new', to: 'medicine_costs#new', as: :new_medicine_cost
      get 'procedure_costs/new', to: 'procedure_costs#new', as: :new_procedure_cost
      post 'medicine_costs', to: 'medicine_costs#create', as: :medicine_costs
      post 'procedure_costs', to: 'procedure_costs#create', as: :procedure_costs
    end
  end
end
