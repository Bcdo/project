# Changelog

## [Unreleased]

- Scripts to do assed and db sync remote
- Explore an atomic deployment solution
- Update in the readme file what to do before deployment, as well as how to deploy.
- Fix the missing php extenstions (imageoptimize)
- Update readme to include aws setup (s3, cloud, sharp)
- Update readme to include webpagetest api instructions
- Update readme file to include the login details and passwords
- Set up a assets volume with the aws settings ready as example. 

## [2.3.0] - 2020-07-25

### Updated
- Composer.json php to 7.4
- Updated changelog to comply with keepachangelog.com

## [2.2.0] - 2020-07-24

### Added
- Added div on settings, sections fields etc.
- Added a seed_dd.sql file in the scriptsfolder

### Updated
- Changed language to en-GB
- Renamed project site name to homepage.
- Readme required tec.
- Readme build instructions

### Fixed
- Fixed schema version skew of craft system.
- Base url site.


## [2.0.0 ]- 2020-07-20
### Added
- Add the scripts to the composer.json
- Add the 'useProjectConfigFile' => true, to the general.php in config
- Add the project.yaml from the projecttest
- Add the plugin craftcms/aws-s3 to the composer.json
- Add npm install on the read me
- Add the config files from the projecttest.
- Add/install redid and make the config work ?? ??
- Added more to the webpack.settings.js pages section
- Added purgecss path to the webpack.settings.js
- Added sitemodule to the module folder

### Changed
- Change the project.yaml files schema version from 3.0.8 to 3.0.9
- Change all the files that has projecttest to it, and write REPLACE_ME
- Change the “REDIS_HOSTNAME=127.0.0.1”
- Updated the env.example
- Checked in the .env.example into git.
- Gitignore .env.sh
- Changed the order of step 2 and 3 in the build instructions, readme file
- Changed the symlink favicon path in webpack.settings.js
- Changed the workbox config swdest path in webpack.settings.js
- Changed the exclude in the webpack.settings.js
- Changed the runtimechaching in webpack.settings.js
- Removed the importScripts script, in the webpack.settings.js

### Fixed
- Changed the #app to #page-container in src/js/app.js. This removed the javascript issue in webpack. See github solved issue #1

## [1.0.3] - 2020-07-18
### Added
- Updated Readme
- Updated package-lock.json

## [1.0.2] - 2020-07-08
### Added
- License.md
- Project type in the composer.json file

## [1.0.1] - 2020-07-08
### Added
- Packagist name, description, version
- Added repositories in composer.json, composer

## [1.0.0] - 2020-07-08
### Added
- Initial release
