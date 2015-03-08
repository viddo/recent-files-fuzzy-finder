{CompositeDisposable} = require 'atom'
{Directory} = require 'pathwatcher'

module.exports =
class WorkspaceObserver
  constructor: (@_recentFiles) ->
    @_workspaceObservers = new CompositeDisposable
    @_workspaceObservers.add atom.workspace.onDidDestroyPaneItem ({ item }) => @_recentFiles.addFromPaneItem(item)
    @_workspaceObservers.add atom.workspace.onDidChangeActivePaneItem (item) => @_recentFiles.addFromPaneItem(item)
    @_workspaceObservers.add atom.project.onDidChangePaths => @_updateProjectDirectoryObservers()

    @_updateProjectDirectoryObservers()

  dispose: ->
    @_workspaceObservers.dispose()
    @_projectDirectoryObservers.dispose()
    @_recentFiles = null

  _updateProjectDirectoryObservers: ->
    @_projectDirectoryObservers.dispose() if @_projectDirectoryObservers
    @_projectDirectoryObservers = new CompositeDisposable
    for path in atom.project.getPaths()
      dir = new Directory(path)
      @_projectDirectoryObservers.add dir.onDidChange => @_recentFiles.removeDeleted()
