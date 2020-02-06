require 'sinatra'
require 'sinatra/reloader' #TODO remove this
require './game/game.rb'

get '/' do
  erb :index
end

get '/game' do
  game = Game.new
  b = game.board
  b.render
  
  # erb :game
end