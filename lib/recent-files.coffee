_ = require 'underscore-plus'
fs = require 'fs-plus'

module.exports =
class RecentFiles
  constructor: (maxFilesToRemember) ->
    @_addsCount = 0
    @_files = {} # path => integer (count value when added)
    @_maxFilesToRemember = maxFilesToRemember

    for path in @_openPaths()
      @_addPath(path)
    @_removeOverflow()

  setMaxFilesToRemember: (newValue) ->
    @_maxFilesToRemember = newValue
    @_removeOverflow()

  addFromPaneItem: (item) ->
    @_addPath item?.getPath?()
    @_removeOverflow()

  setFiles: (files = {}) ->
    @_files = files

  getFiles: ->
    _.clone @_files

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

  dispose: ->
    @_removeByPaths @_paths()

  _removeByPaths: (paths) ->
    for path in paths
      @_files[path] = null
      delete @_files[path]

  _paths: ->
    _.keys(@_files)

  _addPath: (path) ->
    if path? and !@_isTrashed(path)
      @_files[path] = @_addsCount++

  _removeOverflow: () ->
    @_removeByPaths @pathsSortedByLastUsage().slice(@_maxFilesToRemember)

  _isTrashed: (path) ->
    /\.Trash/.test(path)

  _openPaths: ->
    _.chain atom.workspace.getTextEditors()
      .map (editor) => editor.getPath()
      .compact().value()
