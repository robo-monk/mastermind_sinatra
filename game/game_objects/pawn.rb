require_relative '../modules/pawn_settings.rb'
require_relative '../custom_classes/color_string.rb'
require_relative './keys.rb'
class Pawn
  include PawnSettings
  attr_reader :color, :sprite, :purgable
  def initialize(color=0, sprite=1, purgable=true)
    @color = color
    @sprite = sprite
    @purgable = purgable
  end
  private
  def get_sprite
    SPRITE_LIB[(@sprite)%SPRITE_LIB.length]
  end
  public
  def render
    get_sprite.colorize(get_color)
    # "o"
  end
  def change_color reverse = false, col
    @color=col
  end
  def change_sprite reverse = false
    # purgable=true
    # val = 1
    # if reverse then val = -1 end
    # @sprite+=val
    @sprite=0 
  end
  def get_color
    @color
    # åß
    #TODO implement function that translates color code to words
  end
  def activate
    @purgable=false
  end
  def activated?
    return !purgable 
  end
  # def color
  #   @color%COL_LIB.length
  # end
end
