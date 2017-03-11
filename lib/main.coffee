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
      'recent-files-fuzzy-finder:select-next-item': => @createRecentFilesView().selectNextItemView()
      'recent-files-fuzzy-finder:confirm-selection': => @createRecentFilesView().confirmSelection()
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
      # v1.5.0 of FuzzyFinder contains the changeset of https://github.com/atom/fuzzy-finder/pull/273 which is not
      # backward compatible with the recent-files-view due to coffeescript<->ES6 class extends implementation mismatch
      # Use the old version of the view to not break older Atom versions for the time being.
      # Should be able to remove this check once Atom Beta v1.16-beta0 is merged into stable (Atom v1.5+ probably).
      semver = require('semver')
      fuzzyFinderPkgVersion = semver.valid(atom.packages.getLoadedPackage('fuzzy-finder')?.metadata?.version)
      RecentFilesView = if semver.satisfies(fuzzyFinderPkgVersion, '>=1.5.0')
        require './recent-files-view'
      else
        require './recent-files-view-old'

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
