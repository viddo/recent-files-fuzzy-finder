{CompositeDisposable, Directory} = require 'atom'

module.exports =
class WorkspaceObserver
  constructor: (@_recentFiles) ->
    @_workspaceObservers = new CompositeDisposable
    @_workspaceObservers.add atom.workspace.onDidDestroyPaneItem ({item}) => @_recentFiles.addFromPaneItem(item)
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
      try
        @_projectDirectoryObservers.add dir.onDidChange => @_recentFiles.removeDeleted()
      catch err
        # e.g. opening a path that doesn't exist on linux throws an error
        # see https://github.com/viddo/recent-files-fuzzy-finder/issues/3
        console.warn "Could not observe path #{path}", err
