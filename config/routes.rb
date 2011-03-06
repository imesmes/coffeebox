Coffeebox::Application.routes.draw do
  resources :projects do
    resources :tasks do
      resources :intervals, :only => [:index] do 
        collection do
          post :start
          post :stop
        end
      end
    end
  end
end
