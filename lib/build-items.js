const path = require('path')

module.exports = (recentFiles, versionChecks = require('./fuzzy-finder-version-checks')) => {
  const {newInternalItemsFormat} = versionChecks;
  let items = recentFiles.pathsSortedByLastUsage()

  if (newInternalItemsFormat) {
    // based on https://github.com/atom/fuzzy-finder/pull/335/files#diff-07a3a316464ce8b7e18a5b8d8490fab3R26
    const projectHasMultipleDirectories = atom.project.getDirectories().length > 1
    items = items.map(localEditorPath => {
      const [projectRootPath, projectRelativePath] = atom.project.relativizePath(localEditorPath)
      return {
        filePath: localEditorPath,
        label:
          projectRootPath && projectHasMultipleDirectories
            ? path.join(path.basename(projectRootPath), projectRelativePath)
            : projectRelativePath
      }
    });
  }

  const activeTextEditor = atom.workspace.getActiveTextEditor()
  const currentPath = activeTextEditor && activeTextEditor.getPath()

  return items.filter(
    newInternalItemsFormat
      ? ({filePath}) => filePath !== currentPath
      : filePath => filePath !== currentPath
  );
}
