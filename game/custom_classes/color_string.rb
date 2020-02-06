class String
  def colorize(color_code)
    hexes = [ "#B6A6CA", "#F7C59F", "#8AA39B", "#A4F9C8", "#274C77", "#F9F4F5", "#FE938C", "#9ED0E6"]
    "<font color='#{hexes[color_code-30]}'>#{self}</font>"
  end
end
