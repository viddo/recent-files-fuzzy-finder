const path = require('path')
const packagePath = atom.packages.resolvePackagePath('fuzzy-finder')
const FuzzyFinderView = require(path.join(packagePath, 'lib', 'fuzzy-finder-view'))

const buildItems = require('./build-items')

module.exports = class RecentFilesView extends FuzzyFinderView {

  constructor (recentFiles) {
    super()
    this.recentFiles = recentFiles
    this.selectListView.element.classList.add('fuzzy-finder', 'recent-files-fuzzy-finder')
  }

  async toggle () {
    if (this.panel && this.panel.isVisible()) {
      this.cancel()
    } else {
      await this.setItems(buildItems(this.recentFiles))
      this.show()
    }
  }

  getEmptyMessage (itemCount) {
    return itemCount > 0
      ? super.getEmptyMessage()
      : 'No files have been closed recently'
  }

}
