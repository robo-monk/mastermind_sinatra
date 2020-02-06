require 'sinatra'
require 'sinatra/reloader' #TODO remove this
require './game/game.rb'

set :of, 0

get '/' do
  erb :index
end

get '/game' do
  game = Game.new
  b = game.board
  settings.of += 1
  b.color_change_at(settings.of,3)
  b.sprite_change_at(settings.of,3)
  b.render
  # col1 = 'red'
  # erb :game, :locals => {:col1 => col1}
end