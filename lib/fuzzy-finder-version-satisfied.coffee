semver = require('semver')
path = require('path')

packagePath = atom.packages.resolvePackagePath('fuzzy-finder')
pkgJSON = require(path.join(packagePath, 'package.json'))
pkgVersion = semver.valid(pkgJSON?.version)

# v1.5.0 of FuzzyFinder contains the changeset of https://github.com/atom/fuzzy-finder/pull/273 which is not
# backward compatible with the recent-files-view due to coffeescript<->ES6 class extends implementation mismatch
# Use the old version of the view to not break older Atom versions for the time being.
# Should be able to remove this check once Atom Beta v1.16-beta0 is merged into stable (Atom v1.5+ probably).
module.exports = semver.satisfies(pkgVersion, '>=1.5.0')
