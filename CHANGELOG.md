# Change Log
All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/) and [keepachangelog.com](http://keepachangelog.com/).

## [unreleased]

## [0.3.2] - 2017-05-06
### Changed
- Removed check for older Atom versions; new version will require latest Atom stable release (>=1.16.0) #23

### Fixed
- Make selection operations: select-next-item and confirm-selection work again #22

## [0.3.1] - 2017-03-11
### Fixed
- Uncaught TypeError: Class constructor FuzzyFinderView cannot be invoked without 'new' #20

## [0.3.0] - 2017-01-18
### Added
- #18 Expose commands to control RecentFilesView selection
- Lint styles can now be validated through `npm run lint`

### Changed
- Updated dependencies to latest versions

### Fixed
- Fix test case broken on master (Atom handled it internally nowadays)

### Removed
- Unused dependency, `fs-plus`

## [0.2.4] - 2015-12-04
### Fixed
- Restore addsCount after Atom is (re)started, so files appear in the expected sort order; hopefully solves #8

## [0.2.3] - 2015-12-04
### Changed
- Require [Directory](https://atom.io/docs/api/v1.2.4/Directory) model directly from `atom` instead of having it as custom dependency
- Added [coffeelint](http://www.coffeelint.org/) to keep code style consistent
- Fixated package dependency versions to avoid bad surprises

## [0.2.2] - 2015-11-16
### Fixed
- Failed to rebuild/clean install on Atom v1.2.0 #11

## [0.2.1] - 2015-10-07
### Fixed
- Removed a debugger call #9

## [0.2.0] - 2015-09-20
### Added
- Add setting to remember recently used files between sessions, solves #1 and #6

## [0.1.4] - 2015-06-22
### Fixed
- Uncaught Error: Unable to watch path

## [0.1.3] - 2015-05-22
### Fixed
- undefined method call

## [0.1.2] - 2015-04-02
### Fixed
- Update dependency versions, due to upgraded Chrome/node version

## [0.1.1] - 2015-03-19
### Fixed
- require using path join instead of forward-slashes

## [0.1.0] - 2015-03-08
### Added
- Initial release
