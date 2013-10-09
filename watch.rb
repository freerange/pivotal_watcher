require 'bundler/setup'
require 'pivotal-tracker'

ELLIPSIS = '...'
PLAIN_TEXT_EMAIL_LINE_WIDTH = 78

# RestClient.log = $stdout

PivotalTracker::Client.token = ENV['PIVOTAL_TRACKER_API_TOKEN']
project = PivotalTracker::Project.find(ENV['PIVOTAL_TRACKER_PROJECT_ID'])

stories_in_progress = project.stories.all(current_state: ['started'])
features_in_progress = project.stories.all(current_state: ['started'], type: 'feature')
bugs_in_progress = project.stories.all(current_state: ['started'], type: 'bug')

stories_finished = project.stories.all(current_state: ['finished'])
features_finished = project.stories.all(current_state: ['finished'], type: 'feature')
bugs_finished = project.stories.all(current_state: ['finished'], type: 'bug')

stories_blocked = project.stories.all(label: 'blocked', current_state: ['unstarted', 'started'])
stories_in_backlog = project.stories.all(current_state: ['unstarted']).select { |s| s.current_state == 'unstarted' }
stories_unestimated = stories_in_backlog.select { |s| s.estimate == -1 }

def owner_of(owned_by)
  owned_by ? owned_by : 'Unassigned'
end

def truncate(text)
  maximum_length_with_room_for_ellipsis = PLAIN_TEXT_EMAIL_LINE_WIDTH - ELLIPSIS.length
  text.length >= maximum_length_with_room_for_ellipsis ? text[0...maximum_length_with_room_for_ellipsis] + ELLIPSIS : text
end

def generate_report(caption, stories)
  puts "\n#{caption}:\n\n"

  stories.group_by(&:owned_by).sort_by { |owned_by, stories| -stories.length }.each do |owned_by, stories|
    puts "  * #{owner_of(owned_by)} (#{stories.length})"
    stories.each do |story|
      puts truncate(%{    * #{story.name.strip}})
      puts %{      - #{story.url} (#{story.story_type})}
    end
  end
end

generate_report("There are #{stories_in_progress.length} stories in progress (#{features_in_progress.length} features and #{bugs_in_progress.length} bugs)", stories_in_progress)
generate_report("There are #{stories_finished.length} finished stories (#{features_finished.length} features and #{bugs_finished.length} bugs)", stories_finished)
generate_report("There are #{stories_blocked.length} blocked stories in the backlog of #{stories_in_backlog.length} stories", stories_blocked)
generate_report("There are #{stories_unestimated.length} unestimated stories in the backlog of #{stories_in_backlog.length} stories", stories_unestimated)
