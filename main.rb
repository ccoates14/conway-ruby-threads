require 'ruby2d'
require_relative 'cell'

set title: "Conways Game of Life Ruby2D Threads"
set background: 'white'
set width: 1600
set height: 1000

GRID_WIDTH = 130
GRID_HEIGHT = 130
START_X = 50
START_Y = 50

START_DEAD_ZONE = 15

grid = []

for i in 0..GRID_HEIGHT
  cells = []

  for j in 0..GRID_WIDTH
    c = Cell.new(
      grid,
      (j <= START_DEAD_ZONE or j >= GRID_WIDTH - START_DEAD_ZONE or i <= START_DEAD_ZONE or i >= GRID_HEIGHT - START_DEAD_ZONE) ? false : rand(10) > 8,
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
