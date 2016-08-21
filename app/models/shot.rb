class Shot < ActiveRecord::Base
  belongs_to :player

  validates :player, :cell, presence: true
  validates :cell, uniqueness: { scope: :player_id }

  after_create :get_result

  def get_result
    self.update(result: self.player.enemy_board.check_shot(self.cell))
  end
end
