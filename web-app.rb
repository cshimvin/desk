require 'rubygems'
require 'desk'
require 'time'
require 'sinatra'
require './cases.rb'

set :static, true
set :public_folder, File.dirname(__FILE__) + '/static'
set :views, 'views'

get '/active' do
  initialise
  list = active_cases
  puts list
  erb :activecases
end