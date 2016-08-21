Rails.application.routes.draw do
  
  resources :games, only: [:index] do
    collection do
      get "/:player_number", to: "games#player", as: "player"
    end
  end

  get "/waiting", to: "games#waiting", as: "waiting"
  
  put "/new", to: "games#start", as: "new_game"
  put "/quit", to: "games#quit", as: "quit_game"
  put "/shot/:cell", to: "games#shot", as: "take_shot"

  root 'games#index'
end
