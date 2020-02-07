class String
  def colorize(color_code)
    hexes = [ "#F9F4F5", "#8e8e8e", "#F7C59F", "#8AA39B", "#A4F9C8", "#274C77", "#FE938C", "#9ED0E6"]
    "<font color='#{hexes[color_code]}'>#{self}</font>"
  end
end
