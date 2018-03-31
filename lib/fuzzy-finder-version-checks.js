const semver = require('semver')
const path = require('path')

const packagePath = atom.packages.resolvePackagePath('fuzzy-finder')
const pkgJSON = require(path.join(packagePath, 'package.json'))
const pkgVersion = semver.valid(pkgJSON.version)

module.exports = {
  // v1.8.0 of FuzzyFinder contains the changeset of https://github.com/atom/fuzzy-finder/pull/335 which is not
  // backward compatible with the recent-files-view due internal API implementations have changed.
  // Should be able to remove this particular check once Atom Beta v1.26 is on stable channel.
  newInternalItemsFormat: semver.satisfies(pkgVersion, '>=1.8.0')
};
