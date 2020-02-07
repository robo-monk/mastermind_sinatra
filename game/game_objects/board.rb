require_relative './row.rb'
require_relative '../modules/board_settings.rb'
class Board
  include BoardSettings
  attr_accessor :board_matrix, :target_row
  def initialize code_row=nil
    @board_matrix = Array.new
    # @target_row = [1,2,3,4]
    set_target_array code_row
    build
  end
  private
  def build
    BOARD_DIMENSIONS[1].times do |index|
      @board_matrix << Row.new
    end
  end
  public
  def render select=-1, game_over=false
    out = ""
    rendered_string = ""
    rendered_string << (!game_over ? "&nbsp;&nbsp;?&nbsp;&nbsp;?&nbsp;&nbsp;?&nbsp;&nbsp;?&nbsp;&nbsp;&nbsp;&nbsp;" : @target_row.render ) + '<br>'
    # puts (!game_over ? @target_row.render : @target_row.render )
    @board_matrix.reverse.each_with_index do |row, index|
      rendered_string << row.render
      if @board_matrix.length-index-1==select
        # puts row.render(true) + (!game_over ? "  -#{index+1} attempts left" : "- FINAL COMP")
        # puts 'acticated'
      else
        # puts row.render + (row.keys.render) if row.activated?
        if row.activated?
          rendered_string << "&nbsp;&nbsp;"+row.keys.render
        else
          rendered_string << ("&nbsp;&nbsp;")
        end
        # puts 'acticated' if row.activated?
      end
      # puts ""+SPACER+""
      rendered_string << "<br>"

    end
    rendered_string
  end
  def color_change_at x, y, reverse = false, col
    @board_matrix[y].at(x).change_color col
  end
  def sprite_change_at x, y, reverse = false
    @board_matrix[y].at(x).change_sprite
  end
  def reverse_row y
    @board_matrix[y].reverse_sprite_all
  end
  def set_target_array preference=nil
    if preference.nil? then preference = [rand(69),rand(69),rand(69),rand(69)] end
    @target_row = Row.new(preference)
  end
end
