Coffeebox::Application.routes.draw do
  resources :projects do
    resources :tasks
  end
end
