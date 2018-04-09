const path = require('path')

module.exports = (recentFiles, versionChecks = require('./fuzzy-finder-version-checks')) => {
  const {newInternalItemsFormat} = versionChecks;
  const activeTextEditor = atom.workspace.getActiveTextEditor()
  const activeURI = activeTextEditor && activeTextEditor.getURI()
  const items = recentFiles.getItems()

  // From v1.26 and forth this can be deleted, together with the version check
  if (!newInternalItemsFormat) {
    return items.reduce((memo, {filePath, uri}) => {
      if (uri !== activeURI) {
        return memo.concat(filePath)
      }
      return memo
    }, [])
  }

  // based on https://github.com/atom/fuzzy-finder/pull/335/files#diff-07a3a316464ce8b7e18a5b8d8490fab3R26
  const projectHasMultipleDirectories = atom.project.getDirectories().length > 1
  return items.reduce((memo, {filePath, uri}) => {
    if (uri !== activeURI) {
      const [projectRootPath, projectRelativePath] = atom.project.relativizePath(filePath)
      return memo.concat({
        filePath,
        uri,
        label:
          projectRootPath && projectHasMultipleDirectories
            ? path.join(path.basename(projectRootPath), projectRelativePath)
            : projectRelativePath
      })
    }

    return memo;
  }, []);
}
