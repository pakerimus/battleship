class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :get_game
  protect_from_forgery with: :exception

  def get_game
    @game = Game.first
  end

  def current_player
    @current_player ||= Player.find_by_player_number session[:player]
  end
  helper_method :current_player
end
