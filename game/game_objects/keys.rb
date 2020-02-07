require_relative './pawn.rb'
require_relative '../custom_classes/color_string.rb'
class Keys
  attr_accessor :this, :that, :keys_array
  def initialize this, target_array
    @this = this
    @that = target_array
  end
  def find_difference
    black_pins = Array.new
    target_colors = Array.new
    that.row_array.each_with_index do |tpawn, index|
      target_colors << tpawn.color
      if tpawn.color == @this.row_array[index].color
        black_pins << tpawn
      end
    end
    black_pins.each do |pin| target_colors.delete(pin.color) end
    nailed_colors = target_colors.uniq.select do |tcolor|
      this.row_array.any? do |pawn| pawn.color == tcolor end
    end
    @keys_array = [black_pins.length, nailed_colors.length]
    return @keys_array
  end
  def get_array
    @keys_array
  end
  def render
    bw = find_difference
    bl = bw[0]
    wh = bw[1]
    bl_str = "|"*bl
    wh_str = "|"*wh
    return bl_str.colorize(36) + wh_str.colorize(35)
  end
  def all_black?
    find_difference[0] >= 4
  end
end
