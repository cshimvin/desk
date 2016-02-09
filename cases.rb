require 'rubygems'
require 'desk'
require 'time'

# All methods require authentication. To get your Desk OAuth credentials,
# register an app in the Desk.com admin for your account at http://your-domain.desk.com/admin
def initialise
  Desk.configure do |config|
    config.support_email = 'help@example.com'
    config.subdomain = ENV['DESK_SUBDOMAIN']
    config.consumer_key = ENV['DESK_CONSUMER_KEY']
    config.consumer_secret = ENV['DESK_CONSUMER_SECRET']
    config.oauth_token = ENV['DESK_OAUTH_TOKEN']
    config.oauth_token_secret = ENV['DESK_OAUTH_TOKEN_SECRET']
  end
end

def request_dates
  print 'Start date (YYYY-MM-DD): '
  @start_date = gets.chomp
  print 'End date (YYYY-MM-DD): '
  @end_date = gets.chomp
  @start_date_time = @start_date + 'T00:00:01Z'
  @end_date_time = @end_date + 'T23:59:59Z'
end

def output_cases
  casecount = 0
  start_timestamp = Time.parse(@start_date_time).to_i
  end_timestamp = Time.parse(@end_date_time).to_i
  list_cases = Desk.search_cases(:since_created_at => start_timestamp, :max_created_at => end_timestamp, :per_page => 500)
  list_cases.each do |c|
    if c.custom_fields['category'] != 'SPAM'
      casecount += 1
      puts "#{casecount} #{c.created_at} #{c.subject} #{c.status} #{c.custom_fields['category']}"
    end
  end
  puts "Number of cases created between #{@start_date} and #{@end_date} excluding spam is #{casecount}"
end

def active_cases
  puts 'Active cases'
  puts '============'
  active = Desk.search_cases(:status => 'new,open,pending')
  active_file = File.open('data/active.txt', 'w')
  active.each do |c|
    record = "#{c.id}==#{c.subject}==#{c.custom_fields['category']}==#{c.custom_fields['case_type']}==#{c.status}"
    #customer = "#{c.customer.first_name}==#{c.customer.last_name}==#{c.customer.custom_fields['department']}"
    active_file.puts record
    puts record
  end
  active_file.close
end

# request_dates
# output_cases
initialise
active_cases
