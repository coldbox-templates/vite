# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

* * *

## [Unreleased]

## [8.0.1] - 2025-06-11

### Added

- Upgrade to new vite helpers
- Upgrade to latest ColdBox standards

## [7.4.0] - 2025-03-19

### Fixed

- Gitignore updates so it doesn't ignore 'config/modules'

## [7.2.0] - 2023-05-19

### Fixed

- Added `allowPublicKeyRetrieval=true` to the `db` connection string
- Added missing bundle name and version in `.cfconfig.json` and `.env.example`

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

[unreleased]: https://github.com/coldbox-templates/vite/compare/v8.0.1...HEAD
[8.0.1]: https://github.com/coldbox-templates/vite/compare/v7.4.0...v8.0.1
[7.4.0]: https://github.com/coldbox-templates/vite/compare/v7.2.0...v7.4.0
[7.2.0]: https://github.com/coldbox-templates/vite/compare/v7.2.0...v7.2.0
