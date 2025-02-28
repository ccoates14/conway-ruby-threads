require 'ruby2d'
require_relative 'cell'

set title: "Conways Game of Life Ruby2D Threads"
set background: 'white'
set width: 1600
set height: 1000

GRID_WIDTH = 90
GRID_HEIGHT = 90
START_X = 325
START_Y = 50

grid = []

for i in 0..GRID_HEIGHT
  cells = []

  for j in 0..GRID_WIDTH
    c = Cell.new(
      grid,
      rand(10) > 8,
      j,
      i,
      START_X,
      START_Y,
      GRID_WIDTH
    )

    cells.push(c)
  end

  grid.push(cells)
end


update do
  # for each cell update
  for i in 0..GRID_HEIGHT
    for j in 0..GRID_WIDTH
      grid[i][j].update
    end
  end

end

show
