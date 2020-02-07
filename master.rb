require 'sinatra'
require 'sinatra/reloader' #TODO remove this
require './game/game.rb'

set :game, Game.new
set :turns, -1

get '/' do
  erb :index
end

get '/game' do
  settings.turns += 1
  c1 = params['c1'].to_i
  c2 = params['c2'].to_i
  c3 = params['c3'].to_i
  c4 = params['c4'].to_i
  # puts c1,c2,c3,c4
  if settings.turns <12
    settings.game.edit_board(settings.turns, [c1,c2,c3,c4])
    out = settings.game.board.render
  else
    out = "Game Over, fool!"
  end
  # col1 = 'red'
  # puts b.render
  erb :game, :locals => {:board => out}
end