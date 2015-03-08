_ = require 'underscore-plus'
RecentFiles = require '../lib/recent-files'

describe 'Recentfiles', ->
  [recentFiles, maxFilesToRemember]= []

  beforeEach ->
    maxFilesToRemember = 10
    recentFiles = new RecentFiles(maxFilesToRemember)

  it 'will only allow to add files up to the defined max files', ->
    for i in [1..30]
      recentFiles.addFromPaneItem getPath: -> "#{i}"
    expect(recentFiles.pathsSortedByLastUsage()).toEqual ("#{i}" for i in [30...20])

    recentFiles.addFromPaneItem getPath: -> 'a'
    recentFiles.addFromPaneItem getPath: -> 'b'
    expect(recentFiles.pathsSortedByLastUsage()).toEqual _.union(['b','a'], ("#{i}" for i in [30...22]))

    recentFiles.setMaxFilesToRemember(4)
    expect(recentFiles.pathsSortedByLastUsage()).toEqual ['b','a','30', '29']
