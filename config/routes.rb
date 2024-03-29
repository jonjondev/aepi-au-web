Rails.application.routes.draw do
  resources :blog_posts
  resources :notes
  resources :states
  resources :unis
  resources :jobs
  resources :comments
  resources :posts
  resources :boards
  devise_for :users, :controllers => {
    :registrations => "registrations"
  }
  resources :users, only: [:index, :destroy, :update, :edit]

  get 'about', to: 'pages#about_us'
  get 'contact_us', to: 'pages#contact_us'

  get 'contacts/settings', to: 'contacts#settings'
  resources :contacts

	get 'forums/academics', to: 'forums#academics'

	get 'reimbursements/toggle_process', to: 'reimbursements#toggle_process'
	resources :reimbursements

	get 'events/toggle_approve', to: 'events#toggle_approve'
	resources :events

  resources :forums, as: :forum

  devise_scope :user do
    get 'users/sign_out' => "devise/sessions#destroy"
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'pages#landing'
end
