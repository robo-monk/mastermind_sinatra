require 'io/console'
require_relative './game_objects/board.rb'
require_relative './game_objects/player.rb'
require_relative './modules/screen.rb'
class Game
  include BoardSettings
  attr_accessor :board, :player, :turns, :rows_played, :train
  def initialize train=false, player=nil
    @rows_played = Array.new()
    @player = player
    @train = train
    # @board = 'hello mofo'
    @board = Board.new
    @player ||= Player.new "robo"
    # next_state
  end
  def next_state
    current_row.generate_evaluation(@board.target_row)
    if current_row.keys.all_black? then return game_over(current_row) end
    if @turns<BOARD_DIMENSIONS[1]-1
      @turns += 1
      current_row.activate
      edit_board 
    else game_over current_row end
  end
  def edit_board
    cursor=BOARD_DIMENSIONS[0]**2
    @board.sprite_change_at(cursor%BOARD_DIMENSIONS[0], @turns, true)
    update_screen
    @player.get_live_input rows_played do |state|
      case state
      when 'up'
        @board.color_change_at(cursor%BOARD_DIMENSIONS[0], @turns)
      when 'down'
        @board.color_change_at(cursor%BOARD_DIMENSIONS[0], @turns, true)
      when 'right'
        @board.sprite_change_at(cursor%BOARD_DIMENSIONS[0], @turns, true)
        cursor+=1
        @board.sprite_change_at(cursor%BOARD_DIMENSIONS[0], @turns)
      when 'left'
        @board.sprite_change_at(cursor%BOARD_DIMENSIONS[0], @turns, true)
        cursor-=1
        @board.sprite_change_at(cursor%BOARD_DIMENSIONS[0], @turns, true)
      end
      update_screen
    end
    @board.sprite_change_at(cursor%BOARD_DIMENSIONS[0], @turns)
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
      Screen.clear
      @board.render(@turns, game_over)
    end
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

