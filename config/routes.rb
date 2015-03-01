Rails.application.routes.draw do


	#cut off www
	constraints(:host => /^www\./) do
		get "(*x)" => redirect { |params, request|
			ap URI.parse(request.url).tap {|url| url.host.sub!('www.', '') }.to_s
			URI.parse(request.url).tap {|url| url.host.sub!('www.', '') }.to_s
		}
	end
	namespace :admin do
		#resources :users
		root to: 'space#index'
	end

	devise_for :users,
		path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'signup' },
		sign_out_via: [:post, :delete, :get],
		controllers: { registrations: "users/registrations" }

	root to: 'front/landing#index'
end
