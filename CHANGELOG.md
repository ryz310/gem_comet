# Change log

## v0.5.0 (Nov 02, 2019)

### Feature

* [#48](https://github.com/ryz310/gem_comet/pull/48) Add TODO list for the release flow ([@ryz310](https://github.com/ryz310))
* [#49](https://github.com/ryz310/gem_comet/pull/49) Add pull request author names to the changelog generator feature ([@ryz310](https://github.com/ryz310))
* [#54](https://github.com/ryz310/gem_comet/pull/54) Add to todo list to check version numbering ([@ryz310](https://github.com/ryz310))

### Bugfix

* [#50](https://github.com/ryz310/gem_comet/pull/50) Fixed broken version number parsing including obsolete version numbers ([@ryz310](https://github.com/ryz310))
* [#51](https://github.com/ryz310/gem_comet/pull/51) Fix author name parsing ([@ryz310](https://github.com/ryz310))

### Misc

* [#44](https://github.com/ryz310/gem_comet/pull/44) Configure Renovate ([@ryz310](https://github.com/ryz310))
* [#46](https://github.com/ryz310/gem_comet/pull/46) Re-generate .rubocop_todo.yml with RuboCop v0.76.0 ([@ryz310](https://github.com/ryz310))
* [#47](https://github.com/ryz310/gem_comet/pull/47) Update ruby-orbs orb to v1.4.4 ([@ryz310](https://github.com/ryz310))
* [#53](https://github.com/ryz310/gem_comet/pull/53) Use pr comet stubbing ([@ryz310](https://github.com/ryz310))

## v0.4.0 (Oct 27, 2019)

### Feature

* Modify to display gem versions sorted by tagged date ([#32](https://github.com/ryz310/gem_comet/pull/32))
* Add the legend to creating pull requests ([#33](https://github.com/ryz310/gem_comet/pull/33))
* Open the GitHub pull request page at release ([#36](https://github.com/ryz310/gem_comet/pull/36))

### Bugfix

* Fix broken links included by the modified change log ([#34](https://github.com/ryz310/gem_comet/pull/34))

### Breaking Change

* Changelog initializer ([#35](https://github.com/ryz310/gem_comet/pull/35))
    * The `$ gem_comet changelog` command options has changed:
        * Before:
            * `$ gem_comet changelog --from=0.1.0 --to=0.1.1`
        * After:
            * `$ gem_comet changelog --version=v0.1.1`

## 0.3.0 (Oct 19, 2019)

### Feature

* Enhance the feature of changelog command ([#27](https://github.com/ryz310/gem_comet/pull/27))

### Misc

* Re-generate .rubocop_todo.yml with RuboCop v0.75.1 ([#25](https://github.com/ryz310/gem_comet/pull/25))

## 0.2.0 (Oct 14, 2019)

### Feature

* Auto generate change log ([#22](https://github.com/ryz310/gem_comet/pull/22))

## 0.1.1 (Oct 13, 2019)

### Bugfix

* Fix version number validation ([#16](https://github.com/ryz310/gem_comet/pull/16))

### Misc

* Re-generate .rubocop_todo.yml with RuboCop v0.73.0 ([#3](https://github.com/ryz310/gem_comet/pull/3))
* Re-generate .rubocop_todo.yml with RuboCop v0.74.0 ([#5](https://github.com/ryz310/gem_comet/pull/5))
* Re-generate .rubocop_todo.yml with RuboCop v0.75.0 ([#13](https://github.com/ryz310/gem_comet/pull/13))
* ryz310/dependabot/bundler/rake-tw-13.0 ([#9](https://github.com/ryz310/gem_comet/pull/9))
* ryz310/dependabot/bundler/rubocop-performance-1.5.0 ([#14](https://github.com/ryz310/gem_comet/pull/14))
* ryz310/dependabot/bundler/rspec-3.9.0 ([#17](https://github.com/ryz310/gem_comet/pull/17))

## 0.1.0 (Jul 16, 2019)

Initial release :rocket:
