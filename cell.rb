require 'gosu'

DEAD = Gosu::Color::WHITE
NEW_BORN = Gosu::Color::RED
ADULT = Gosu::Color::YELLOW
OLD_ADULT = Gosu::Color::BLUE

class Cell
  def initialize(grid, alive, index_x, index_y, start_x, start_y, grid_width, window)
    @grid = grid
    @alive = alive
    @index_x = index_x
    @index_y = index_y
    @current_color = alive ? NEW_BORN : DEAD
    @size = 10
    @x = (index_x * @size) + start_x
    @y = (index_y * @size) + start_y
    @grid_width = grid_width
    @age = 0
    @window = window
  end

  def draw_self
    @window.draw_rect(@x, @y, 3, 3, @current_color)
  end

  # Any live cell with fewer than two live neighbours dies, as if by underpopulation.
  # Any live cell with two or three live neighbours lives on to the next generation.
  # Any live cell with more than three live neighbours dies, as if by overpopulation.
  # Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.

  def update
    draw_self
    live_neighbors = count_live_neighbors

    if !@alive and live_neighbors > 2 and live_neighbors < 7
      @alive = true
    elsif live_neighbors < 2 or live_neighbors >= 7
      @alive = false
      @age = 0
    end

    if @alive
      @age += 1

      if @age == 1
        @current_color = NEW_BORN
      elsif @age > 8
      @alive = false
      elsif @age > 6
        @current_color = OLD_ADULT
      elsif @age > 2
        @current_color = ADULT
      end
    else
      @current_color = DEAD
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
