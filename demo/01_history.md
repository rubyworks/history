# History Class

The history class encapsulates this list of release
made by a project. It parses a text file by the
name of HISTORY into it indivdual relase entries.

Given a HISTORY project file containing:

    = RELEASE HISTORY

    == 1.2.0 / 2010-10-18

    Some Dandy description of the 1.2.0 release.
    This is  multiline description.

    Changes:

    * This is change 1.
    * This is change 2.
    * This is change 3.


    == 1.1.0 | 2010-06-06 | "Happy Days"

    Some Dandy description of the 1.1.0 release.
    This is  multiline description. Notice the
    header varies from the first.

    The description can even have multiple paragraphs.

    Changes:

    * This is change 1.
    * This is change 2.
    * This is change 3.


    == 1.0.0 / 2010-04-30

    Some Dandy description of the 1.0.0 release.
    This is  multiline description. Notice that
    the "changes:" label isn't strictly needed.

    * This is change 1.
    * This is change 2.
    * This is change 3.


    == 0.9.0 / 2010-04-10

    1. This is change 1.
    2. This is change 2.
    3. This is change 3.

    Some Dandy description of the 0.9.0 release.
    Notice this time that the changes are listed
    first and are numerically enumerated.

The History class provides an interface to this information.
The initializer takes the root directory for the project
and looks for a file called +HISTORY+, optionally ending
in an extension such as +.txt+ or +.rdoc+, etc.

    history = History.at('tmp/example')

Now we should have an enumeration of each release entry in
the HISTORY file.

    history.releases.size.assert == 4

The non-plurual #release method will give us the first entry.
And we can see that it has been parsed into its component
attributes.

    history.release.header.assert == '== 1.2.0 / 2010-10-18'
    history.release.notes.assert.index('description of the 1.2.0')

The header is further parsed into version, date and nickname if given.

    history.release.version.assert == '1.2.0'
    history.release.date.assert    == '2010-10-18'

We should see like results for the other release entries.

    history.releases[2].version.assert == '1.0.0'
    history.releases[2].date.assert    == '2010-04-30'

    history.releases[2].header.assert == '== 1.0.0 / 2010-04-30'
    history.releases[2].notes.assert.index('description of the 1.0.0')
    history.releases[2].changes.assert.index('This is change 1')

Even though there are variations in the formats of each entry they are
still parsed correctly. For example the second release has a nick name.

    history.releases[1].nickname.assert == 'Happy Days'

And the last entry has it's changes listed before the description.

    history.releases[3].header.assert == '== 0.9.0 / 2010-04-10'
    history.releases[3].notes.assert.index('description of the 0.9.0')
    history.releases[3].changes.assert.index('This is change 1')

The history parser is farily simplistic, but it is flexibile enough
to parse the most common HISTORY file formats.

