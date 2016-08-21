class Game < ActiveRecord::Base
  has_many :players

  SHIP_QUANTITY_BY_TYPE = {
    "aircraf_carrier" => 1,
    "battleship" => 2,
    "cruiser" => 3,
    "destroyer" => 4,
    "submarine" => 5
  }.freeze

  def restart
    Shot.delete_all
    Ship.delete_all
    [self.player1, self.player2].each_with_index do |player, index|
      if player
        myboard = player.board
      else
        p = self.players.create(player_number: index+1)
        myboard = Board.create(player: p)
      end
      myboard.set_placing!
    end
    self.players.create(player_number: 2) unless player2
    self.update(status: "placing", current_player: 1)
  end

  def enemy(player_number)
    player_number == 1 ? self.player2 : self.player1
  end

  def player1
    self.players.find_by_player_number 1
  end

  def player2
    self.players.find_by_player_number 2
  end

  def change_turn!
    self.update(status: "playing") if self.current_player == 2 && self.status == "placing"
    self.update(current_player: (current_player == 1 ? 2 : 1))
  end

  def finish!(player_number)
    self.update(status: "Finished! #{player_number} won!", current_player: nil)
  end

end
