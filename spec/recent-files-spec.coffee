RecentFiles = require '../lib/recent-files'

describe 'Recentfiles', ->
  [recentFiles]= []

  beforeEach ->
    recentFiles = new RecentFiles
    recentFiles.setMaxFilesToRemember(10)
    spyOn(console, 'warn') # avoid console output in test

  it 'will keep a sorted list of items up to the max limit', ->
    for i in [1..30]
      recentFiles.addFromPaneItem
        getURI: -> "uri://#{i}"
        getPath: -> "#{i}"
    items = recentFiles.getItems()
    expect(items.map ({filePath}) -> filePath).toEqual ("#{i}" for i in [30...20])
    expect(items.map ({uri}) -> uri).toEqual ("uri://#{i}" for i in [30...20])

    recentFiles.addFromPaneItem
      getPath: -> 'a'
      getURI: -> 'uri://a'
    recentFiles.addFromPaneItem
      getPath: -> 'b'
      getURI: -> 'uri://b'
    items = recentFiles.getItems()
    expect(items.map ({filePath}) -> filePath).toEqual ['b', 'a'].concat("#{i}" for i in [30...22])
    expect(items.map ({uri}) -> uri).toEqual ['uri://b', 'uri://a'].concat("uri://#{i}" for i in [30...22])

    recentFiles.setMaxFilesToRemember(4)
    items = recentFiles.getItems()
    expect(items.map ({filePath}) -> filePath).toEqual ['b', 'a', '30', '29']
    expect(items.map ({uri}) -> uri).toEqual ['uri://b', 'uri://a', 'uri://30', 'uri://29']

    recentFiles.addFromPaneItem
      getPath: -> null
      getURI: -> 'uri://malformed'
    recentFiles.addFromPaneItem
      getPath: -> 'malformed'
      getURI: -> null
    expect(recentFiles.getItems()).not.toEqual([])
    recentFiles.removeDeleted()
    waitsFor "recent files to have been checked", 500, ->
      recentFiles.getItems().length is 0
    runs ->
      expect(recentFiles.getItems()).toEqual([])
