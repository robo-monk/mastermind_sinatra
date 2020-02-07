require 'io/console'
require_relative './game_objects/board.rb'
require_relative './game_objects/player.rb'
require_relative './modules/screen.rb'
class Game
  include BoardSettings
  attr_accessor :board, :player, :turns, :rows_played, :train, :won
  def initialize cols, train=false, player=nil
    @rows_played = Array.new()
    @player = player
    @train = train
    # @board = 'hello mofo'
    @board = Board.new(cols)
    @turns = 12
    @player ||= Player.new "robo"
    @won = false
    # next_state
  end
  def next_state
    current_row.generate_evaluation(@board.target_row)
    if current_row.keys.all_black? then @won = true; puts = 'get rexk'; return end #game_over(current_row) end
    if @turns<BOARD_DIMENSIONS[1]-1
      current_row.activate
    else game_over current_row end
  end
  def edit_board(turns, row_array_colors)
    @turns = turns
    next_state
    cursor=BOARD_DIMENSIONS[0]**2
    # @board.sprite_change_at(cursor%BOARD_DIMENSIONS[0], @turns, true)
    update_screen
    row_array_colors.each_with_index do |col, index|
      @board.color_change_at(index, @turns, true, col)
      @board.sprite_change_at(index, @turns)
        # b.sprite_change_at(settings.of%3,3)

    end
    @board.reverse_row @turns
    rows_played<<current_row
    next_state
  end
  def current_row
    @board.board_matrix[turns]
  end
  def game_over final_row, won=false
    update_screen true
    # rows_played.each do |row| puts row.render + row.keys.render end
  end
  def get_board
    @board
  end
  def update_screen game_over = false
    if train 
      # print "|"
    else
      @board.render(@turns, game_over)
    end
  end
  def won?
    won
  end
end

# albert = Player.new("albert", true)
# iterations = 50000
# iterations.times do |iter|
#   g=Game.new(true, albert)
#   albert.save_game g.board.target_row
#   percentage = (iter.to_f/iterations)*100
#   if (percentage%(1) == 0)
#     Screen.clear
#     puts percentage.to_i.to_s + "%"
#   end
# end
# puts " won"
# albert.games_memory.each do |game| puts "---------------"; game[0].each do |row| puts row.to_s end end
# albert.start_running_ai
# esc = 'not'
# while esc!='escape'
#   g=Game.new(false, albert)
#   puts 'type escape to close and lose all albert data'
#   esc = gets.chomp.downcase
# end

# Screen.get_live_input do |val|
#       Screen.clear
#       @board.render

