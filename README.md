Sets up a cron job to generate a report on the state of a PivotalTracker project using the PivotalTracker API and email it to the designated recipients.

* The stories in progress - the intention being that you should keep your work-in-progress under control
* Blocked stories in the backlog (i.e. labelled "blocked") - to highlight obstacles to progress
* Unestimated stories in the backlog - to highlight stories that may not be ready to work on

### Requirements

* Ruby 1.9
* cron & command line email e.g. mailutils & postfix

## Credits

Pivotal Watcher was written by [James Mead](http://jamesmead.org) and the other members of [Go Free Range](http://gofreerange.com).


## License

Pivotal Watcher is released under the [MIT License](https://github.com/freerange/pivotal_watcher/blob/master/LICENSE).