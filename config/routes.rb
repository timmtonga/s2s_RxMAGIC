Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'main#index'

  ###################### Main Controller ##################################

  get "/main/settings"
  get "/select_report" => "main#select_report"
  post "/main/report"
  ###################### Drug Controller ##################################
  get "/drug/search"
  get "/void_drug/:id" => "drug#destroy"
  post "/edit_drug" => "drug#edit"

  ###################### General Inventory Controller #####################
  get "/void_general_inventory/:id" => "general_inventory#destroy"
  post "/void_general_inventory" => "general_inventory#destroy"
  post "/edit_general_inventory" => "general_inventory#edit"
  get "/general_inventory/expired_items"
  get "/general_inventory/expiring_items"
  get "/general_inventory/understocked"
  get "/general_inventory/wellstocked"
  get "view_gn_drug/:id" => "general_inventory#view_drug"
  get "/print_bottle_barcode/:id" => "general_inventory#print_bottle_barcode"
  get "/ajax_bottle/:id" => "general_inventory#ajax_bottle"

  ###################### User Controller #############################
  get "/username_availability" => "users#username_availability"
  get "/login" => "user#login"
  post "/login" => "user#login"
  get '/logout' => "user#logout"
  get "/query_users" => "user#query"
  get "/void_user/:id" => "user#destroy"
  post "/edit_user" => "user#edit"

  ###################### Prescription Controller ##############################
  get "/void_prescriptions/:id" => "prescription#destroy"
  get "/prescriptions" => "prescription#ajax_prescriptions"
  post "/prescription/dispense"
  post "/prescription/edit"


  ###################### Dispensation Controller ##############################
  get "/dispensation/refill"
  post "/refill" => "dispensation#refill"
  get "/print_dispensation_label/:id" => "dispensation#print_dispensation_label"
  get "/void_dispensation/:id" => "dispensation#destroy"

  ###################### Mobile Visit Controller ##############################
  get "/void_mobile_visit/:id" => "mobile_visit#destroy"

  ###################### Mobile Visit Product Controller ######################
  get "/void_mobile_visit_product/:id" => "mobile_visit_product#destroy"


  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  resources :mobile_visit
  resources :mobile_visit_product
  resources :general_inventory
  resources :drug_threshold
  resources :patient
  resources :prescription
  resources :main
  resources :user
  resources :dispensation
  resources :drug

end
