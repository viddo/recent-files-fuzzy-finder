_ = require 'underscore-plus'
fs = require 'fs'

module.exports =
class RecentFiles

  atom.deserializers.add(this)
  @deserialize: ({data}) -> new RecentFiles(data)
  serialize: ->
    {
      deserializer: 'RecentFiles'
      data: @_files
    }

  constructor: (prevFiles = {}) ->
    @_addsCount = 0
    @_files = {} # path => integer (addsCount value at the time of path being added, used for sorting)
    @_maxFilesToRemember = 1000000

    @_addPath(path) for path of prevFiles
    @_addPath(path) for path in @_openPaths()
    @_removeOverflow()

  setMaxFilesToRemember: (newValue) ->
    @_maxFilesToRemember = newValue
    @_removeOverflow()

  addFromPaneItem: (item) ->
    @_addPath item?.getPath?()
    @_removeOverflow()

  pathsSortedByLastUsage: ->
    _.sortBy @_paths(), (path) =>
      -@_files[path]

  removeClosed: ->
    @_removeByPaths _.difference @_paths(), @_openPaths()

  removeDeleted: ->
    for path in @_paths()
      ((path) =>
        fs.stat path, (err, stats) =>
          @_removeByPaths([path]) if err
      )(path)

  _removeByPaths: (paths) ->
    for path in paths
      @_files[path] = null
      delete @_files[path]

  _paths: ->
    _.keys(@_files)

  _addPath: (path) ->
    if path? and not @_isTrashed(path)
      @_files[path] = @_addsCount++

  _removeOverflow: ->
    @_removeByPaths @pathsSortedByLastUsage().slice(@_maxFilesToRemember)

  _isTrashed: (path) ->
    /\.Trash/.test(path)

  _openPaths: ->
    _.chain atom.workspace.getTextEditors()
      .map (editor) -> editor.getPath()
      .compact().value()
