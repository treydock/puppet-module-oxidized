# Change log

All notable changes to this project will be documented in this file. The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/) and this project adheres to [Semantic Versioning](http://semver.org).

## [v1.0.0](https://github.com/treydock/puppet-module-oxidized/tree/v1.0.0) (2021-07-08)

[Full Changelog](https://github.com/treydock/puppet-module-oxidized/compare/v0.7.3...v1.0.0)

### Changed

- Depend on puppet/rhsm for RedHat, update supported dependency versions [\#20](https://github.com/treydock/puppet-module-oxidized/pull/20) ([treydock](https://github.com/treydock))
- Major updates \(see description\) [\#18](https://github.com/treydock/puppet-module-oxidized/pull/18) ([treydock](https://github.com/treydock))

### Added

- Allow installing specific version of packages [\#23](https://github.com/treydock/puppet-module-oxidized/pull/23) ([treydock](https://github.com/treydock))
- Support EL8 [\#22](https://github.com/treydock/puppet-module-oxidized/pull/22) ([treydock](https://github.com/treydock))
- Support Ubuntu 20.04 [\#21](https://github.com/treydock/puppet-module-oxidized/pull/21) ([treydock](https://github.com/treydock))

## [v0.7.3](https://github.com/treydock/puppet-module-oxidized/tree/v0.7.3) (2020-03-12)

[Full Changelog](https://github.com/treydock/puppet-module-oxidized/compare/v0.7.2...v0.7.3)

### Fixed

- Notify service when configs changes and fix rugged dependency issue [\#16](https://github.com/treydock/puppet-module-oxidized/pull/16) ([treydock](https://github.com/treydock))

## [v0.7.2](https://github.com/treydock/puppet-module-oxidized/tree/v0.7.2) (2019-12-16)

[Full Changelog](https://github.com/treydock/puppet-module-oxidized/compare/v0.7.1...v0.7.2)

### Fixed

- Add missing model directory [\#14](https://github.com/treydock/puppet-module-oxidized/pull/14) ([treydock](https://github.com/treydock))

## [v0.7.1](https://github.com/treydock/puppet-module-oxidized/tree/v0.7.1) (2019-11-08)

[Full Changelog](https://github.com/treydock/puppet-module-oxidized/compare/v0.7.0...v0.7.1)

### Fixed

- Fix path for model file [\#13](https://github.com/treydock/puppet-module-oxidized/pull/13) ([treydock](https://github.com/treydock))

## [v0.7.0](https://github.com/treydock/puppet-module-oxidized/tree/v0.7.0) (2019-11-07)

[Full Changelog](https://github.com/treydock/puppet-module-oxidized/compare/v0.6.2...v0.7.0)

### Added

- Support defining models or model patches [\#12](https://github.com/treydock/puppet-module-oxidized/pull/12) ([treydock](https://github.com/treydock))
- Support defining oxidized log file [\#11](https://github.com/treydock/puppet-module-oxidized/pull/11) ([treydock](https://github.com/treydock))

## [v0.6.2](https://github.com/treydock/puppet-module-oxidized/tree/v0.6.2) (2019-09-12)

[Full Changelog](https://github.com/treydock/puppet-module-oxidized/compare/v0.6.1...v0.6.2)

### Fixed

- Fix CSV router.db mapping to take into account mapping parameters [\#10](https://github.com/treydock/puppet-module-oxidized/pull/10) ([treydock](https://github.com/treydock))

## [v0.6.1](https://github.com/treydock/puppet-module-oxidized/tree/v0.6.1) (2019-09-12)

[Full Changelog](https://github.com/treydock/puppet-module-oxidized/compare/v0.6.0...v0.6.1)

### Fixed

- Fix permissions on /etc/oxidized/config [\#9](https://github.com/treydock/puppet-module-oxidized/pull/9) ([treydock](https://github.com/treydock))

## [v0.6.0](https://github.com/treydock/puppet-module-oxidized/tree/v0.6.0) (2019-09-10)

[Full Changelog](https://github.com/treydock/puppet-module-oxidized/compare/v0.5.1...v0.6.0)

### Added

- Fix config modes and support changing home and config modes [\#8](https://github.com/treydock/puppet-module-oxidized/pull/8) ([treydock](https://github.com/treydock))
- Support defining CSV device map and vars\_map [\#7](https://github.com/treydock/puppet-module-oxidized/pull/7) ([treydock](https://github.com/treydock))

## [v0.5.1](https://github.com/treydock/puppet-module-oxidized/tree/v0.5.1) (2019-09-09)

[Full Changelog](https://github.com/treydock/puppet-module-oxidized/compare/v0.5.0...v0.5.1)

### Fixed

- Fix CSV config [\#6](https://github.com/treydock/puppet-module-oxidized/pull/6) ([treydock](https://github.com/treydock))

## [v0.5.0](https://github.com/treydock/puppet-module-oxidized/tree/v0.5.0) (2019-09-09)

[Full Changelog](https://github.com/treydock/puppet-module-oxidized/compare/v0.4.0...v0.5.0)

### Added

- Allow show\_diff to be set for files [\#5](https://github.com/treydock/puppet-module-oxidized/pull/5) ([treydock](https://github.com/treydock))

## [v0.4.0](https://github.com/treydock/puppet-module-oxidized/tree/v0.4.0) (2019-08-07)

[Full Changelog](https://github.com/treydock/puppet-module-oxidized/compare/v0.3.0...v0.4.0)

### Added

- Add ability to manage oxidized service [\#4](https://github.com/treydock/puppet-module-oxidized/pull/4) ([treydock](https://github.com/treydock))

## [v0.3.0](https://github.com/treydock/puppet-module-oxidized/tree/v0.3.0) (2019-08-05)

[Full Changelog](https://github.com/treydock/puppet-module-oxidized/compare/v0.2.0...v0.3.0)

### Added

- Support Debian and Ubuntu [\#3](https://github.com/treydock/puppet-module-oxidized/pull/3) ([treydock](https://github.com/treydock))

## [v0.2.0](https://github.com/treydock/puppet-module-oxidized/tree/v0.2.0) (2019-08-05)

[Full Changelog](https://github.com/treydock/puppet-module-oxidized/compare/v0.1.0...v0.2.0)

### Added

- Manage oxidized-web [\#2](https://github.com/treydock/puppet-module-oxidized/pull/2) ([treydock](https://github.com/treydock))
- Support EL6 [\#1](https://github.com/treydock/puppet-module-oxidized/pull/1) ([treydock](https://github.com/treydock))

## [v0.1.0](https://github.com/treydock/puppet-module-oxidized/tree/v0.1.0) (2019-08-05)

[Full Changelog](https://github.com/treydock/puppet-module-oxidized/compare/f0dbdaa7fd7a8747d0cf2d5d3700dd422af6e202...v0.1.0)



\* *This Changelog was automatically generated by [github_changelog_generator](https://github.com/github-changelog-generator/github-changelog-generator)*
