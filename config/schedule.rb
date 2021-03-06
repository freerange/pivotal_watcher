# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

env :PATH, '/usr/local/bin:/usr/bin:/bin'
env :MAILTO, 'everyone@gofreerange.com'
env :PIVOTAL_WATCHER_RECIPIENTS, 'product@futurelearn.com'

every :weekday, at: '7am' do
  # Write the script output to a file and then, if the file has a size greater than 0, mail the content of the file to everyone
  # command 'cd ~/app && rm -f tmp-script-output && bundle exec ruby watch.rb > tmp-script-output 2>&1; if [ -s tmp-script-output ]; then cat tmp-script-output | mail -s "Pivotal Tracker Watcher Report" $PIVOTAL_WATCHER_RECIPIENTS; fi'
end
