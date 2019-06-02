# Change Log
All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/) and [keepachangelog.com](http://keepachangelog.com/).

## [unreleased]

## [1.0.0] - 2019-06-02
### Changed
- Support Atom +v1.37
- Update all deps [#37](https://github.com/viddo/recent-files-fuzzy-finder/issues/37)

### Fixed
- Fix support for Atom 1.37 (and maybe a few older versions) [#36](https://github.com/viddo/recent-files-fuzzy-finder/issues/36)


## [0.6.1] - 2018-04-14
### Fixed
- Check that item is considered valid before adding it to recent items list [#33](https://github.com/viddo/recent-files-fuzzy-finder/issues/33)


## [0.6.0] - 2018-04-08
### Fixed
- Fix confirm selection working for +v1.26-beta when having multiple project folders open

### Removed
- `underscore-plus`, no longer necessary


## [0.5.0] - 2018-03-31
### Changed
- Make package compatible with new internal fuzzy-finder format as of Atom v1.126-beta [#31](https://github.com/viddo/recent-files-fuzzy-finder/pull/31)


## [0.4.0] - 2017-12-07
### Changed
- Updates all deps [#25](https://github.com/viddo/recent-files-fuzzy-finder/pull/25)
- Show view with empty message if there are no recently closed files [#26](https://github.com/viddo/recent-files-fuzzy-finder/pull/26)

### Removed
- Cleanup: `semver` dependency, no longer used, since [#23](https://github.com/viddo/recent-files-fuzzy-finder/pull/23)


## [0.3.2] - 2017-05-06
### Changed
- Removed check for older Atom versions; new version will require latest Atom stable release (>=1.16.0) [#23](https://github.com/viddo/recent-files-fuzzy-finder/pull/23)

### Fixed
- Make selection operations: select-next-item and confirm-selection work again [#22](https://github.com/viddo/recent-files-fuzzy-finder/pull/22)


## [0.3.1] - 2017-03-11
### Fixed
- Uncaught TypeError: Class constructor FuzzyFinderView cannot be invoked without 'new' [#20](https://github.com/viddo/recent-files-fuzzy-finder/pull/20)


## [0.3.0] - 2017-01-18
### Added
- [#18](https://github.com/viddo/recent-files-fuzzy-finder/pull/18) Expose commands to control RecentFilesView selection
- Lint styles can now be validated through `npm run lint`

### Changed
- Updated dependencies to latest versions

### Fixed
- Fix test case broken on master (Atom handled it internally nowadays)

### Removed
- Unused dependency, `fs-plus`


## [0.2.4] - 2015-12-04
### Fixed
- Restore addsCount after Atom is (re)started, so files appear in the expected sort order; hopefully solves [#8](https://github.com/viddo/recent-files-fuzzy-finder/pull/8)


## [0.2.3] - 2015-12-04
### Changed
- Require [Directory](https://atom.io/docs/api/v1.2.4/Directory) model directly from `atom` instead of having it as custom dependency
- Added [coffeelint](http://www.coffeelint.org/) to keep code style consistent
- Fixated package dependency versions to avoid bad surprises


## [0.2.2] - 2015-11-16
### Fixed
- Failed to rebuild/clean install on Atom v1.2.0 [#11](https://github.com/viddo/recent-files-fuzzy-finder/pull/11)


## [0.2.1] - 2015-10-07
### Fixed
- Removed a debugger call [#9](https://github.com/viddo/recent-files-fuzzy-finder/pull/9)


## [0.2.0] - 2015-09-20
### Added
- Add setting to remember recently used files between sessions, solves [#1](https://github.com/viddo/recent-files-fuzzy-finder/pull/1) and [#6](https://github.com/viddo/recent-files-fuzzy-finder/pull/6)


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
