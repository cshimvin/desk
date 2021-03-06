require 'rubygems'
require 'desk'
require 'time'
require 'sinatra'
require './cases.rb'

set :static, true
set :public_folder, File.dirname(__FILE__) + '/static'
set :views, 'views'

get '/active/?' do
  initialise
  erb :activecases
end

get '/case/:caseid/?' do
  if params['caseid'] =~ /[0-9]/
    initialise
    customer_name_email = get_customer_name_email(params['caseid'])
    case_details(params['caseid'])
    erb :showcase, :locals => {
      'caseid' => params['caseid'],
      'case_details' => @details,
      'status' => @status,
      'created' => @created,
      'updated' => @updated,
      'case_notes' => @notes,
      'case_replies' => @replies,
      'customer_name_email' => customer_name_email
    }
  else
    erb :error, :locals => {
      'error' => 'Invalid case number'
    }
  end
end
