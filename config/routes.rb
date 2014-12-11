Kurov::Application.routes.draw do
  root "pages#home"    
  get "home", to: "pages#home", as: "home"
  get "inside", to: "pages#inside", as: "inside"
  get "/contact", to: "pages#contact", as: "contact"
  post "/emailconfirmation", to: "pages#email", as: "email_confirmation"
  
  get "blog", to: "pages#posts", as: "posts"
  get "blog/:id", to: "pages#show_post", as: "post"    
  devise_for :users, path: '', path_names: {sign_in: 'login', sign_out: 'logout'}
  
  namespace :admin do
    root 'base#index'
    resources :users
    get "posts/drafts", to: "posts#drafts", as: "posts_drafts"
    get "posts/dashboard", to: "posts#dashboard", as: "posts_dashboard"
    resources :posts
  end
  
end
