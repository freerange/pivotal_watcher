require 'bundler/setup'
require 'pivotal-tracker'

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

def reference(story)
  story.name[/^(FL\d+)\s/]
  $1
end

def generate_report(caption, stories)
  puts "\n#{caption}:\n\n"

  stories.group_by(&:owned_by).each do |owned_by, stories|
    puts "  * #{owner_of(owned_by)}"
    stories.each do |story|
      puts "    * #{story.url} (#{[reference(story), story.story_type, story.current_state].compact.join(', ')})"
    end
  end
end

generate_report("There are #{stories_in_progress.length} stories in progress (#{features_in_progress.length} features and #{bugs_in_progress.length} bugs)", stories_in_progress)
generate_report("There are #{stories_finished.length} finished stories (#{features_finished.length} features and #{bugs_finished.length} bugs)", stories_finished)
generate_report("There are #{stories_blocked.length} blocked stories in the backlog of #{stories_in_backlog.length} stories", stories_blocked)
generate_report("There are #{stories_unestimated.length} unestimated stories in the backlog of #{stories_in_backlog.length} stories", stories_unestimated)
