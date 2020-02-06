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
    out << "│"+SPACER + "<br>"
    out << (!game_over ? "   ?   ?   ?   ?" : @target_row.render )+ "<br>"
    # puts (!game_over ? @target_row.render : @target_row.render )
    out << "│"+SPACER+ "<br>"
    rendered_array = Array.new
    @board_matrix.reverse.each_with_index do |row, index|
      rendered_array << row.render
      if @board_matrix.length-index-1==select
        out<< row.render(true) + (!game_over ? "  -#{index+1} attempts left" : "- FINAL COMP")+ "<br>"
      else
        out << row.render + (row.keys.render)+ "<br>" if row.activated?
      end
      out << "│"+SPACER+"│"+ "<br>"
    end
    rendered_array
    puts out
    return out
  end
  def color_change_at x, y, reverse = false
    @board_matrix[y].at(x).change_color reverse
  end
  def sprite_change_at x, y, reverse = false
    @board_matrix[y].at(x).change_sprite reverse
  end
  def reverse_row y
    @board_matrix[y].reverse_sprite_all
  end
  def set_target_array preference=nil
    if preference.nil? then preference = [rand(69),rand(69),rand(69),rand(69)] end
    @target_row = Row.new(preference)
  end
end
