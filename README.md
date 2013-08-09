Sets up a cron job to generate a report on the state of a PivotalTracker project using the PivotalTracker API and email it to the designated recipients.

* The stories in progress - the intention being that you should keep your work-in-progress under control
* Blocked stories in the backlog (i.e. labelled "blocked") - to highlight obstacles to progress
* Unestimated stories in the backlog - to highlight stories that may not be ready to work on

### Requirements

* Ruby 1.9
* cron & command line email e.g. mailutils & postfix
