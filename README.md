<a href="https://codeclimate.com/github/tchorzewski1991/smartstats/maintainability"><img src="https://api.codeclimate.com/v1/badges/2ade2348dc8de81b93f6/maintainability" /></a> [![Build Status](https://travis-ci.org/tchorzewski1991/smartstats.svg?branch=master)](https://travis-ci.org/tchorzewski1991/smartstats) [![Coverage Status](https://coveralls.io/repos/github/tchorzewski1991/smartstats/badge.svg?branch=master)](https://coveralls.io/github/tchorzewski1991/smartstats?branch=master) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

# SmartStats

SmartStats is a simple .log files analyzer. It is a PET project created due to specific requirements,
mostly for training purposes. It shouldn't be considered as a 'complete' tool for production use.

Features included:
- simple CLI for better user experience
- terminal-table wrapper around output stream for better presentation layer
- configured set of code analysis tools like:
  - reek for code smells detection
  - rubocop as a static code analyzer, based mostly on thoughtbot's configuration
  - codeclimate as an external service for code quality measurment

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'smartstats'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install smartstats

## Usage

SmartStats provide simple and clean CLI for better experience when parsing your .log files. To see all possible
commands run simple:

```
smartstats
```

You should see output like the following:

```
Commands:
  smartstats help [COMMAND]  # Describe available commands or one specific command
  smartstats parse PATH      # Parses .log file under PATH and generates someuseful stats
  smartstats version         # Displays smartstats version
```

Above interface is pretty straight forward due to power of [thor](https://github.com/erikhuda/thor) gem.

Running smartstats command on .log file like this:

```
smartstats parse webserver.log
```

where given file contains following structure:

```
─$ cat webserver.log
/index 126.318.035.038
/index 126.318.035.038
/about 184.123.665.067
/index 126.318.035.039
/about 184.123.665.067
```

would report output similar to:

```
+--------------+------+
|     All Traces      |
+--------------+------+
| Uri          | Hits |
+--------------+------+
| /about       | 2    |
+--------------+------+
| /index       | 3    |
+--------------+------+
+--------------+------+
|     Uniq Traces     |
+--------------+------+
| Uri          | Hits |
+--------------+------+
| /about       | 1    |
+--------------+------+
| /index       | 2    |
+--------------+------+

```

All log 'traces' will be sorted by the given 'route' as well as grouped by the number of hits
encountered within that single route

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tchorzewski1991/smartstats.
