Rails.application.routes.draw do

	get "/404", :to => "errors#not_found"
	get "/422", :to => "errors#unacceptable"
	get "/500", :to => "errors#internal_error"


	Dir[Rails.root.join('lib').join('api').join('*.rb').to_s].each { |file| require file }

	devise_for :users

	root 'home#show'

	namespace :api do
		resources :ptrs
		resources :domains do
			resources :as, controller: :as
			resources :cnames, controller: :cnames
			resources :mxes, controller: :mxes
			resources :nameservers, controller: :nameservers
			resources :ddns, controller: :ddns
			resources :members, controller: :members
			resource :soa, controller: :soa
		end
	end

	resources :domains

	resource :profile
	resource :admin do
		root 'admin_users#index'
		resources :users, controller: 'admin_users'
		resources :domains, controller: 'admin_domains'
	end



	# The priority is based upon order of creation: first created -> highest priority.
	# See how all your routes lay out with "rake routes".

	# You can have the root of your site routed with "root"
	# root 'welcome#index'

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
end
