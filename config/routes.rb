Coffeebox::Application.routes.draw do
  match 'teambox/sync' => 'teambox#sync'

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
