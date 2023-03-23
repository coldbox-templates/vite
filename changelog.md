# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

* * *

## [Unreleased]

- Updated `.cfconfig.json` to latest standards and properties to assist in development

## [6.19.0] - 2023-03-22

### Regression

- Reverted the `lib/vendor` convention as this is on cb7 not cb6.

## [6.18.0] - 2023-03-21

### Added

- New automated changelogs
- Workflow updates for autocommit formatting and pr formatting checks

## [6.17.0] => 2023-MAR-20

### Added

- Application helper : `loadViteManifest()` to encapsulate the loading of the manifest.
- Changelog Tracking
- Github actions for auto building
- Latest ColdBox standards
- UI Updates
- Latest Alpine + Bootstrap Combo
- vscode introspection and helpers
- Docker build and compose consolidation to the `build` folder
- Cleanup of `tests` to new standards
- Added routing conventions to make it easier for the cli to add routes.

[Unreleased]: https://github.com/coldbox-templates/vite/compare/v6.19.0...HEAD

[6.19.0]: https://github.com/coldbox-templates/vite/compare/v6.18.0...v6.19.0

[6.18.0]: https://github.com/coldbox-templates/vite/compare/76f465f4b542dc77e14756aec1cb1622f9d99f21...v6.18.0
