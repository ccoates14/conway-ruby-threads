

class Cell
  def initialize(grid, alive, index_x, index_y, start_x, start_y, grid_width)
    @grid = grid
    @alive = alive
    @index_x = index_x
    @index_y = index_y
    @draw_state_dirty = true
    @current_color = 'white'
    @size = 10
    @x = (index_x * @size) + start_x
    @y = (index_y * @size) + start_y
    @grid_width = grid_width
    @square = nil
  end

  def draw_self
    if @draw_state_dirty
      if @square.nil?
        @square = Square.new(
          x: @x, y: @y,   # Position
          size: @size - 1,         # Side length
          color: @current_color    # Color
        )
      end
      @square.color = @current_color
    end
  end

  # Any live cell with fewer than two live neighbours dies, as if by underpopulation.
  # Any live cell with two or three live neighbours lives on to the next generation.
  # Any live cell with more than three live neighbours dies, as if by overpopulation.
  # Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.

  def update
    draw_self

    @draw_state_dirty = false
    live_neighbors = count_live_neighbors

    if !@alive and live_neighbors == 3
      @alive = true
      @current_color = 'green'
      @draw_state_dirty = true
    elsif live_neighbors < 2 or live_neighbors > 3
      @alive = false
      @current_color = 'white'
      @draw_state_dirty = true
    end
  end

  def count_live_neighbors
    live_neighbors = 0

    #top
    if @grid[(@index_y - 1) % @grid.length][@index_x].alive
      live_neighbors += 1
    end
    #topleft
    if @grid[(@index_y - 1) % @grid.length][(@index_x - 1) % @grid_width].alive
      live_neighbors += 1
    end
    #topright
    if @grid[(@index_y - 1) % @grid.length][(@index_x + 1) % @grid_width].alive
      live_neighbors += 1
    end

    #left
    if @grid[@index_y][(@index_x - 1) % @grid_width].alive
      live_neighbors += 1
    end

    #right
    if @grid[@index_y][(@index_x + 1) % @grid_width].alive
      live_neighbors += 1
    end

    #bottom
    if @grid[(@index_y + 1) % @grid.length][@index_x].alive
      live_neighbors += 1
    end
    #bottomleft
    if @grid[(@index_y + 1) % @grid.length][(@index_x - 1) % @grid_width].alive
      live_neighbors += 1
    end
    #bottomright
    if @grid[(@index_y + 1) % @grid.length][(@index_x + 1) % @grid_width].alive
      live_neighbors += 1
    end

    live_neighbors
  end

  def alive
    @alive
  end
end
