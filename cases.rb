require 'rubygems'
require 'desk'
require 'time'

# All methods require authentication. To get your Desk OAuth credentials,
# register an app in the Desk.com admin for your account at http://your-domain.desk.com/admin
Desk.configure do |config|
  config.support_email = 'help@example.com'
  config.subdomain = ENV['DESK_SUBDOMAIN']
  config.consumer_key = ENV['DESK_CONSUMER_KEY']
  config.consumer_secret = ENV['DESK_CONSUMER_SECRET']
  config.oauth_token = ENV['DESK_OAUTH_TOKEN']
  config.oauth_token_secret = ENV['DESK_OAUTH_TOKEN_SECRET']
end

######
# List examples
######

start_date = '2016-01-28T00:00:01Z'
end_date = '2016-02-01T00:00:01Z'

# List cases
#cases = Desk.cases
#cases.each do |c|
#  puts c.status
#end

start_timestamp = Time.parse(start_date).to_i
end_timestamp = Time.parse(end_date).to_i
list_cases = Desk.cases(:since_created_at => start_timestamp, :max_created_at => end_timestamp, :per_page => 500)
list_cases.each do |c|
  if (c.labels[0] != "Spam")
    puts "#{c.created_at} #{c.subject} #{c.status}"
  end
end

#Desk.create_insights_report(
#  :resolution => "days",
#  :min_date => "2016-01-28",
#  :max_date => "2016-02-01",
#  :dimension1_name => "*",
#  :dimension1_values => "*",
#  :dimension2_name => "*",
#  :dimension2_values => "*"
#)

