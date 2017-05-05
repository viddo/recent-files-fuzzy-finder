/** @babel */

import path from 'path'

const packagePath = atom.packages.resolvePackagePath('fuzzy-finder')
const FuzzyFinderView = require(path.join(packagePath, 'lib', 'fuzzy-finder-view'))

export default class RecentFilesView extends FuzzyFinderView {

  constructor (recentFiles) {
    super()
    this.recentFiles = recentFiles
    this.selectListView.element.classList.add('fuzzy-finder', 'recent-files-fuzzy-finder')
  }

  async toggle () {
    if (this.panel && this.panel.isVisible()) {
      this.cancel()
    } else {
      const activeTextEditor = atom.workspace.getActiveTextEditor()

      let paths = this.recentFiles.pathsSortedByLastUsage()
      if (activeTextEditor && activeTextEditor.getPath() === paths[0]) {
        paths = paths.slice(1)
      }

      if (paths.length > 0) {
        await this.setItems(paths)
        this.show()
      }
    }
  }

  getEmptyMessage (itemCount) {
    return itemCount > 0
      ? super.getEmptyMessage()
      : 'No files have been closed recently'
  }

}
