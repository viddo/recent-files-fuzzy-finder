fs = require 'fs'

TRASH_PATH_REGEX = /\.Trash/

module.exports =
class RecentFiles

  atom.deserializers.add(this)
  @deserialize: ({data}) ->
    new RecentFiles(data)
  serialize: ->
    {
      deserializer: 'RecentFiles'
      data: @_items
      version: RecentFiles.version
    }
  @version: 2

  constructor: (prevItems = []) ->
    @_items = []
    @_addItem(item) for item in prevItems.reverse().concat(@_openItems())
    @_removeOverflow()

  setMaxFilesToRemember: (newValue) ->
    @_maxFilesToRemember = newValue
    @_removeOverflow()

  addFromPaneItem: (paneItem) ->
    if paneItem and paneItem.getPath
      item =
        filePath: paneItem.getPath()
        uri: paneItem.getURI()
      @_addItem(item)
      @_removeOverflow()

  getItems: ->
    @_items.slice()

  removeClosed: ->
    openURIs = @_openItems().map ({uri}) -> uri
    @_items = @_items.filter ({uri}) -> openURIs.includes(uri)

  removeDeleted: ->
    @_items.forEach ({filePath, uri}) =>
      fs.stat filePath, (err, stats) =>
        if err
          @_items = @_items.filter (x) -> x.uri isnt uri

  _addItem: (item) ->
    if not item or not item.filePath or not item.uri or @_isTrashed(item)
      try
        serializedItem = JSON.stringify(item)
      catch err
        serializedItem = err
      console.warn("[recent-files-fuzzy-finder] trying to add invalid item: #{serializedItem}")
      return
    items = @_items.filter(({uri}) -> uri isnt item.uri)
    items.unshift(item)
    @_items = items

  _removeOverflow: ->
    @_items = @_items.slice(0, @_maxFilesToRemember)

  _isTrashed: ({filePath}) ->
    TRASH_PATH_REGEX.test(filePath)

  _openItems: ->
    atom.workspace.getTextEditors().map (x) ->
      filePath: x.getPath()
      uri: x.getURI()
