class Ship < ActiveRecord::Base
  belongs_to :board

  SIZE_BY_TYPE = {
    "aircraf_carrier" => 5,
    "battleship" => 4,
    "cruiser" => 3,
    "destroyer" => 2,
    "submarine" => 1
  }.freeze

  before_create :default_values

  def default_values
    self.status = "placing"
    mycells = {}
    SIZE_BY_TYPE[self.shiptype].times do |i|
      mycells[i] = {}
      mycells[i] = {cell: "", status: "ready"}
    end
    self.cells = mycells
  end

  def hit!(index, a_cell)
    my_cells = eval self.cells
    my_cells[index][:status] = "hit"
    my_status = self.check_status
    self.update(cells: my_cells, status: my_status)
    self.board.check_status if my_status == "destroyed"
  end

  def check_status
    if self.board.player.game.status == "playing"
      eval(self.cells).each do |cell|
        return "ready" if cell[1][:status] == "ready"
      end
      return "destroyed"
    end
  end
end
