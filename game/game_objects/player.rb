require_relative '../modules/screen.rb'
require_relative '../modules/pawn_settings.rb'
class Player
  include PawnSettings
  attr_accessor :name, :automated, :games_memory, :game_memory, :data, :run, :last_move
  def initialize name, automated=false
    @name = name
    @automated = automated
    @game_memory = Array.new
    @games_memory = Array.new
    @run = false
    @last_move = Array.new
  end
  def get_live_input row_memory
    if !automated
      Screen.get_live_input do |state|
        yield state
      end
    else
      if @run then @data = run_ai(row_memory) else @data = train_ai(row_memory) end
      @data.each_with_index do |d, index|
        d.times do yield 'down' end
        yield 'right'
      end
    end
  end
  def train_ai row_memory
    moves = Array.new
    4.times do |i|
      moves << rand(COL_LIB.length)
    end
    if !row_memory.last.nil? then @game_memory << [@data, row_memory.last.keys.get_array] end
    return moves
  end
  def run_ai row_memory
    moves = Array.new
    super_moves = Hash.new
    # row = row_memory[row_memory.length-1]
    if row_memory.length>0
      # row = row_memory[-1]
      row_memory.each do |row|
        @games_memory[row.keys.get_array].each do |drow|
          if row.color_array == drow[1]
            super_moves[drow[0]] ||= 0
            super_moves[drow[0]] += 1
          end
        end
      end
    end
    # end
    max_val = 0
    super_moves.each do |key, value|
      # puts row_memory[-1].color_array.to_s, key.to_s
      if value > max_val && !row_memory.any?{|row| row.color_array==key}
        puts @last_move.to_s, key.to_s
        max_val = value
        moves = key
      end
    end
    # moves = super_moves[rand(super_moves.length)]
    if super_moves.length<1
      puts "yeet it"
      moves = Array.new
      4.times do |i|
        moves << rand(COL_LIB.length)
      end
    end
    @last_move = moves
    return moves
  end
  def save_game win_row
    @game_memory.each do |row|
      row << win_row.color_array
      @games_memory << row
    end
    # puts @games_memory.to_s
    @game_memory = Array.new
  end
  def analyze_data
    filtered_data = Hash.new
    @games_memory.each_with_index do |row, index|
      filtered_data[row[1]] ||= Array.new
      filtered_data[row[1]] << [row[0], row[2]]
    end
    puts "__"
    # puts filtered_data[[0, 1]].to_s
    @games_memory = filtered_data
  end
  def start_running_ai
    analyze_data
    @run = true
  end
end

# p = Player.new "ru", true
# p