path = require 'path'
packagePath = atom.packages.resolvePackagePath('fuzzy-finder')
FuzzyFinderView = require path.join(packagePath, 'lib', 'fuzzy-finder-view')

module.exports =
class RecentFilesView extends FuzzyFinderView
  initialize: (@recentFiles) ->
    super
    
    @addClass('recent-files-fuzzy-finder')

  toggle: ->
    if @panel?.isVisible()
      @cancel()
    else
      paths = @recentFiles.pathsSortedByLastUsage()
      paths = if paths[0] is atom.workspace.getActiveTextEditor()?.getPath() then paths.slice(1) else paths
      if paths.length > 0
        @setItems paths
        @show()

  getEmptyMessage: (itemCount) ->
    if itemCount is 0
      'No files have been closed recently'
    else
      super
