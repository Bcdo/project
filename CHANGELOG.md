# Changelog

## [Unreleased]

- Explore an atomic deployment solution
- Update in the readme file what to do before deployment, as well as how to deploy.
- Set up a assets volume with the aws settings ready as example.

## [2.5.0] -

### Added
- Add native image lazy loading

## [2.4.0] - 2020-07-29

### Added
- Added TypeScript support
- Use Vue.js 3.0

### Changed
- Replaced moment with vanilla JavaScript
- Replaced `getenv()` with `App::env()`
- No longer use DSN for db connections
- Switch from TSLint to ESLint
- Disabled the ForkTS plugins for now.

### Fixed
- Fixed config path in the module `helpers/Config.php`

### Updated
- Readme visuals

## [2.3.4] - 2020-07-28

### Fixed
- Composer.json

## [2.3.3] - 2020-07-28

### Updated
- Readme change buil dinstruction to include composer
- Added lisence to packagist, MIT.

## [2.3.2] - 2020-07-28

### Added
- Scripts folder for different tasks (such as db and asset sync, etc)

### Updated
- Readme file to include sync script setup.
- Gitignore .env.sh in scripts folder.  
- Composer.json version, as well as readme url to pre-commit checklist.
- Fixed packagist

## [2.3.1] - 2020-07-26

### Updated
- Updated readme with login details.
- Updated readme to include asset handling setup (s3, cloud, sharp)
- Updated readme to include the webpagetest for webperf.

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
