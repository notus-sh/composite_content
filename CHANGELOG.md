# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed

* Compatibility with Cocooned 2.1 (#15)
* Compatibility with Rails 7.1 (#14)
* Update test matrix (#14)  
  Add Ruby 3.3. Drop Ruby 2.6 and Ruby 2.7


## Version 2.1.0 (2023-08-29)

### Added

* Allow to customize strong parameters names on a block class with `.strong_parameters_names` (#11)
* Allow to change composite_content views base path with `CompositeContent::Engine.config.views_path` (#10)

### Fixed

* Typo in french translations

## Version 2.0.0 (2023-03-07)

### Breaking changes

* Update Cocooned dependency to `~2.0.0` (#5)  
  If you installed a previous version of `composite_content`, you may need to run installation generator again or to apply to your templates changes suggested in [Cocooned migration guide](https://github.com/notus-sh/cocooned#from-cocooned-10).

### Changed

* Reduce RuboCop configuration to minimal (#6)
* Migrate from Travis CI to Github Actions (#2)
* Add Ruby 3.2 to the test matrix (#1)

## Version 1.0.0 (2022-08-06)

* Initial release
