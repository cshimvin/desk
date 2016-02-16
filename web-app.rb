require 'rubygems'
require 'desk'
require 'time'
require 'sinatra'
require './cases.rb'

set :static, true
set :public_folder, File.dirname(__FILE__) + '/static'
set :views, 'views'

get '/active/' do
  initialise
  erb :activecases
end

get '/case/:caseid' do
  if params['caseid'] =~ /[0-9]/
    initialise
    erb :showcase, :locals => {
      'caseid' => params['caseid']
    }
  else
    erb :error, :locals => {
      'error' => 'Invalid case number'
    }
  end
end
