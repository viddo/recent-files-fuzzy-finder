module.exports =
  config:
    maxFilesToRemember:
      type: 'number'
      default: 50
      minimum: 1
    restoreSession:
      description: 'Set to true to remember recent files between sessions (i.e. after Atom is closed and re-opened)'
      type: 'boolean'
      default: false

  activate: (state) ->
    @configSubscription = atom.config.observe 'recent-files-fuzzy-finder.maxFilesToRemember', (val) =>
      @createRecentFiles(state).setMaxFilesToRemember(val)

    atom.commands.add 'atom-workspace', {
      'recent-files-fuzzy-finder:toggle-finder': => @createRecentFilesView().toggle()
      'recent-files-fuzzy-finder:remove-closed-files': => @recentFiles.removeClosed()
      'recent-files-fuzzy-finder:select-next-item': => @createRecentFilesView().selectListView.selectNext()
      'recent-files-fuzzy-finder:confirm-selection': => @createRecentFilesView().selectListView.confirmSelection()
    }

  createRecentFiles: (state) ->
    unless @recentFiles?
      RecentFiles = require './recent-files'
      if atom.config.get('recent-files-fuzzy-finder.restoreSession')
        @recentFiles = atom.deserializers.deserialize(state)
      @recentFiles ||= new RecentFiles
      WorkspaceObserver = require './workspace-observer'
      @workspaceObserver = new WorkspaceObserver(@recentFiles)
    @recentFiles

  createRecentFilesView: ->
    unless @recentFilesView?
      RecentFilesView = require './recent-files-view'
      @recentFilesView = new RecentFilesView(@recentFiles)
    @recentFilesView

  serialize: ->
    @recentFiles?.serialize()

  deactivate: ->
    if @recentFilesView?
      @recentFilesView.destroy()
      @recentFilesView = null
    if @workspaceObserver?
      @workspaceObserver.dispose()
      @workspaceObserver = null
    if @recentFiles?
      @recentFiles = null
    if @configSubscription?
      @configSubscription.dispose()
      @configSubscription = null
