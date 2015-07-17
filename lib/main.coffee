module.exports =
  config:
    maxFilesToRemember:
      type: 'number'
      default: 50
      minimum: 1

  activate: (state) ->
    @configSubscription = atom.config.observe 'recent-files-fuzzy-finder.maxFilesToRemember', (val) =>
      @createRecentFiles(val, state).setMaxFilesToRemember(val)

    atom.commands.add 'atom-workspace', {
      'recent-files-fuzzy-finder:toggle-finder': => @createRecentFilesView().toggle()
      'recent-files-fuzzy-finder:remove-closed-files': => @recentFiles.removeClosed()
    }

  createRecentFiles: (maxFilesToRemember, state)->
    unless @recentFiles?
      RecentFiles = require './recent-files'
      @recentFiles = new RecentFiles(maxFilesToRemember)
      @recentFiles.setFiles state?.files
      WorkspaceObserver = require './workspace-observer'
      @workspaceObserver = new WorkspaceObserver(@recentFiles)
    @recentFiles

  createRecentFilesView: ->
    unless @recentFilesView?
      RecentFilesView = require './recent-files-view'
      @recentFilesView = new RecentFilesView(@recentFiles)
    @recentFilesView

  serialize: ->
    { files: @recentFiles.getFiles() }

  deactivate: ->
    if @recentFilesView?
      @recentFilesView.destroy()
      @recentFilesView = null
    if @workspaceObserver?
      @workspaceObserver.dispose()
      @workspaceObserver = null
    if @recentFiles?
      @recentFiles.dispose()
      @recentFiles = null
    if @configSubscription?
      @configSubscription.dispose()
      @configSubscription = null
