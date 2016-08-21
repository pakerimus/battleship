class Board < ActiveRecord::Base
  belongs_to :player
  has_many :ships

  def create_ships!
    Game::SHIP_QUANTITY_BY_TYPE.each do |ships|
      ships[1].times do 
        self.ships.create(shiptype: ships[0])
      end
    end
  end

  def set_placing!
    self.update(status: "placing")
    self.create_ships!
    self
  end

  def set_ready!
    self.ships.update_all(status: "ready")
    self.update(status: "ready")
  end

  def check_shot(a_cell)
    self.ships.each do |ship|
      eval(ship.cells).each do |cell|
        if cell[1][:cell] == a_cell
          ship.hit!(cell[0], a_cell)
          return "hit"
        end
      end
    end
    self.player.game.change_turn!
    "water"
  end

  def check_status
    self.player.game.finish!(self.player.player_number) if self.player.enemy_board.ships.ready.empty?
  end
end
