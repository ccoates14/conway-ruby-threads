

class Cell
  def initialize(grid, alive, index_x, index_y, start_x, start_y, grid_width)
    @grid = grid
    @alive = alive
    @index_x = index_x
    @index_y = index_y
    @draw_state_dirty = true
    @current_color = alive ? 'green' : 'white'
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

    # update stuff
    # if something changes we mark drawstate dirty
    # dirty state changes if it gets hungrier or dies

    #count number of neighbors alive
    live_neighbors = count_live_neighbors

    if !@alive and live_neighbors == 3
      @alive = true
      @draw_state_dirty = true
    elsif live_neighbors < 2 or live_neighbors > 3
      @alive = false
      @draw_state_dirty = true
    end

     @current_color = @alive ? 'green' : 'white'
  end

  def count_live_neighbors
    live_neighbors = 0

    #top
    if @index_y - 1 >= 0
      if @grid[@index_y - 1][@index_x].alive
        live_neighbors += 1
      end
    end
    #topleft
    if @index_y - 1 >= 0 and @index_x - 1 >= 0
      if @grid[@index_y - 1][@index_x - 1].alive
        live_neighbors += 1
      end
    end
    #topright
    if @index_y - 1 >= 0 and @index_x + 1 < @grid_width
      if @grid[@index_y - 1][@index_x + 1].alive
        live_neighbors += 1
      end
    end

    #left
    if @index_x - 1 >= 0
      if @grid[@index_y][@index_x - 1].alive
        live_neighbors += 1
      end
    end

    #right
    if @index_x + 1 < @grid_width
      if @grid[@index_y][@index_x + 1].alive
        live_neighbors += 1
      end
    end

    #bottom
    if @index_y + 1 < @grid.length
      if @grid[@index_y + 1][@index_x].alive
        live_neighbors += 1
      end
    end
    #bottomleft
    if @index_y + 1 < @grid.length and @index_x - 1 >= 0
      if @grid[@index_y + 1][@index_x - 1].alive
        live_neighbors += 1
      end
    end
    #bottomright
    if @index_y + 1 < @grid.length and @index_x + 1 < @grid_width
      if @grid[@index_y + 1][@index_x + 1].alive
        live_neighbors += 1
      end
    end

    live_neighbors
  end

  def alive
    @alive
  end
end
