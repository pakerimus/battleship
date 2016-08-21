class GamesController < ApplicationController
  before_action :check_player, only: [:index]
  before_action :set_player, only: [:player]

  def index
  end

  def player
    redirect_to waiting_path unless @game.current_player == session[:player]
    @params = params
  end

  def waiting
  end

  def start
    @game.restart
    redirect_to games_path, notice: "Game started"
  end

  def quit
    @game.quit!(session[:player])
    session[:player] = nil
    redirect_to games_path, notice: "You quit!"
  end

  def shot
    result = @game.take_shot(session[:player], params[:cell])
    render json: result
  end

  private

  def check_player
    if session[:player].present? && @game.playable?
      redirect_to player_games_path(session[:player])
    end
  end

  def set_player
    if params[:player_number].present? && @game.playable?
      session[:player] ||= params[:player_number]
    else
      redirect_to games_path
    end
  end
end
