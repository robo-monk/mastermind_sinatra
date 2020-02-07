require 'sinatra'
require 'sinatra/reloader' #TODO remove this
require './game/game.rb'

set :game, Game.new([rand(8),rand(8),rand(8),rand(8)])
# set :game, Game.new([1,1,1,1])

set :turns, -1

get '/' do
  erb :index
end

get '/game' do
  settings.turns += 1
  c1 = params['c1']
  c2 = params['c2']
  c3 = params['c3']
  c4 = params['c4']
  if c1.nil? || c2.nil? || c3.nil? || c4.nil?
    restart
    out = settings.game.board.render
  else
    if settings.turns < 11 
      settings.game.edit_board(settings.turns, [c1.to_i,c2.to_i,c3.to_i,c4.to_i])
      out = settings.game.board.render
    else
      out = 'you suckkk :('
    end
    if settings.game.won?
      out = "you won!"
    end
  end
  erb :game, :locals => {:board => out}
end

get '/about' do
  erb :about
end

def restart
  settings.turns = -1
  settings.game = Game.new([rand(8),rand(8),rand(8),rand(8)])
end