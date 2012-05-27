---
source:
- var
authors:
- name: trans
  email: transfire@gmail.com
copyrights:
- holder: Rubyworks
  year: '2012'
  license: BSD-2-Clause
requirements:
- name: detroit
  groups:
  - build
  development: true
- name: qed
  groups:
  - test
  development: true
- name: ae
  groups:
  - test
  development: true
dependencies: []
alternatives: []
conflicts: []
repositories:
- uri: git://github.com/rubyworks/history.git
  scm: git
  name: upstream
resources:
- uri: http://rubyworks.github.com/history
  label: Website
  type: home
- uri: http://github.com/rubyworks/history
  label: Source Code
  type: code
- uri: http://github.com/rubyworks/history/issues
  label: Issue Tracker
  type: bugs
- uri: http://groups.google.com/groups/rubyworks-mailinglist
  label: Mailing List
  type: mail
- uri: irc://us.chat.freenode.net/rubyworks
  label: IRC Channel
  type: chat
categories: []
extra: {}
load_path:
- lib
revision: 0
name: history
title: History
created: '2010-02-19'
organization: Rubyworks
summary: HISTORY and CHANGELOG parser
version: 0.3.0
description: ! 'History is a HISTORY file parser. It can parse common HISTORY file
  layouts

  and provide the contents in a structured model. This can be useful for

  a number of things, in particular it can be used to generate tag messages

  and add pre-release change lists to release announcements.'
date: '2012-05-27'
