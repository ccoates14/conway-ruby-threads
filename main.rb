require 'gosu'
require 'thread'
require_relative 'cell'

class GameWindow < Gosu::Window

  def initialize
    super 1600, 1200

    @rect_draw_queue = Queue.new
  end

  def draw
    while !@rect_draw_queue.empty?
      rect = @rect_draw_queue.pop

      Gosu.draw_rect(rect[:x], rect[:y], rect[:w], rect[:h], rect[:color])
    end
  end

  def draw_rect(x, y, w, h, color)
    @rect_draw_queue << {
      x:,
      y:,
      w:,
      h:,
      color:
    }
  end
end

window = GameWindow.new

GRID_WIDTH = 150
GRID_HEIGHT = 150
START_X = 140
START_Y = 0

START_DEAD_ZONE = 15

grid = []

for i in 0..GRID_HEIGHT
  cells = []

  for j in 0..GRID_WIDTH
    c = Cell.new(
      grid,
      (j <= START_DEAD_ZONE or j >= GRID_WIDTH - START_DEAD_ZONE or i <= START_DEAD_ZONE or
        i >= GRID_HEIGHT - START_DEAD_ZONE) ? false : rand(10) > 8,
      j,
      i,
      START_X,
      START_Y,
      GRID_WIDTH,
      window
    )

    cells.push(c)
  end

  grid.push(cells)
end

THREAD_COUNT = 5
threads_rows = []
threads = []

current_thread_row = 0

(0..(THREAD_COUNT - 1)).each do |i|
  threads_rows.push([])
end

while current_thread_row < grid.length
  (0..(THREAD_COUNT - 1)).each do |i|
    threads_rows[i].push(grid[current_thread_row])
    current_thread_row += 1

    if current_thread_row >= grid.length
      break
    end
  end
end


mutex = Mutex.new

(0..(THREAD_COUNT - 1)).each do |i|
  threads << Thread.new do
    n = i
    rows_to_update = threads_rows[n]

    while true
      rows_to_update.each do |row|
        row.each do |c|
          mutex.synchronize do
            c.update
          end
        end
      end

      sleep 0.016
    end
  end
end


window.show
