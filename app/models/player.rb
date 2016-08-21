class Player < ActiveRecord::Base
  belongs_to :game
  has_one :board
  has_many :shots

  validates :game, :player_number, presence: true

  def enemy_board
    self.game.enemy(self.player_number).board
  end

  def ready!
    self.board.set_ready!
    self.game.change_turn!
  end
end
