[Homepage](http://rubyworks.github.com/history) |
[Report Issue](http://github.com/rubyworks/history/issues) |
[Source Code](http://github.com/rubyworks/history)
( [![Build Status](https://secure.travis-ci.org/rubyworks/indexer.png)](http://travis-ci.org/rubyworks/indexer) )


# History

History is a HISTORY file parser. It can parse common HISTORY file layouts
and provide the contents in a structured model. This can be useful for
a number of things, in particular it can be used to generate tag messages
and add pre-release change lists to release announcements.


## Usage

Basic usage is fairly straight forward. Load a history file using
the `History.at` method.

```ruby
    history = History.at('HISTORY.rdoc')
```

Then you have access the the current release with:

```ruby
    history.release.header
    history.release.notes
    history.release.version
    history.release.date
    history.release.codename
    history.release.changes
```

And all releases with with an index:

```ruby
    history.releases[i].header
    history.releases[i].notes
    history.releases[i].version
    history.releases[i].date
    history.releases[i].codename
    history.releases[i].changes
```


## Contact

Need help, want to make a suggestion or just shoot the shit about this whole idea,
try one of these channels.

* [Issue Tracker](http://groups.google.com/groups/rubyworks-mailinglist)
* [Mailing List](http://github.com/rubyworks/history/issues)
* [IRC Channel](irc://us.chat.freenode.net/rubyworks)


## Copyrights

HIstory is copyrighted open source software.

    Copyright (c) 2012 Rubyworks 

It is distributable and modifiable in accordance with the 
[BSD-2-Clause](http://spdx.org/license/bsd-2-clause) license.

See LICENSE.txt file for details.
