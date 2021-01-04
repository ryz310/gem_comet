# Change log

## v0.7.1 (Jan 04, 2021)

### Feature
### Bugfix
### Breaking Change
### Misc

* [#214](https://github.com/ryz310/gem_comet/pull/214) Fix dependency ([@ryz310](https://github.com/ryz310))

## v0.7.0 (Jan 04, 2021)

### Breaking Change

* [#178](https://github.com/ryz310/gem_comet/pull/178) End of support for Ruby 2.4 ([@ryz310](https://github.com/ryz310))
* [#211](https://github.com/ryz310/gem_comet/pull/211) Support ruby 3.0 ([@ryz310](https://github.com/ryz310))

### Rubocop Challenger

* [#129](https://github.com/ryz310/gem_comet/pull/129) Performance/StartWith-20200523233027 ([@ryz310](https://github.com/ryz310))
* [#206](https://github.com/ryz310/gem_comet/pull/206) Re-generate .rubocop_todo.yml with RuboCop v1.7.0 ([@ryz310](https://github.com/ryz310))

### Dependabot

* [#74](https://github.com/ryz310/gem_comet/pull/74) Bump thor from 1.0.0 to 1.0.1 ([@ryz310](https://github.com/ryz310))
* [#112](https://github.com/ryz310/gem_comet/pull/112) ryz310/dependabot/bundler/pry-byebug-3.9.0 ([@ryz310](https://github.com/ryz310))
* [#176](https://github.com/ryz310/gem_comet/pull/176) ryz310/dependabot/bundler/rspec-3.10.0 ([@ryz310](https://github.com/ryz310))
* [#200](https://github.com/ryz310/gem_comet/pull/200) ryz310/dependabot/bundler/rubocop-1.6.1 ([@ryz310](https://github.com/ryz310))
* [#203](https://github.com/ryz310/gem_comet/pull/203) ryz310/dependabot/bundler/rubocop-rspec-2.1.0 ([@ryz310](https://github.com/ryz310))
* [#204](https://github.com/ryz310/gem_comet/pull/204) ryz310/dependabot/bundler/rake-13.0.2 ([@ryz310](https://github.com/ryz310))
* [#207](https://github.com/ryz310/gem_comet/pull/207) ryz310/dependabot/bundler/yard-0.9.26 ([@ryz310](https://github.com/ryz310))
* [#210](https://github.com/ryz310/gem_comet/pull/210) ryz310/dependabot/bundler/rubocop-performance-1.9.2 ([@ryz310](https://github.com/ryz310))

### Misc

* [#71](https://github.com/ryz310/gem_comet/pull/71) Rename service classes to add verb to prefix ([@ryz310](https://github.com/ryz310))
* [#96](https://github.com/ryz310/gem_comet/pull/96) Update ruby-orbs orb to v1.6.0 ([@ryz310](https://github.com/ryz310))
* [#113](https://github.com/ryz310/gem_comet/pull/113) Edit dependabot configuration ([@ryz310](https://github.com/ryz310))

## v0.6.1 (Nov 22, 2019)

### Misc

* [#64](https://github.com/ryz310/gem_comet/pull/64) Bump rubocop-performance from 1.5.0 to 1.5.1 ([@ryz310](https://github.com/ryz310))
* [#63](https://github.com/ryz310/gem_comet/pull/63) ryz310/dependabot/bundler/rake-13.0.1 ([@ryz310](https://github.com/ryz310))
* [#65](https://github.com/ryz310/gem_comet/pull/65) Update ruby-orbs orb to v1.4.5 ([@ryz310](https://github.com/ryz310))

## v0.6.0 (Nov 03, 2019)

### Feature

* [#60](https://github.com/ryz310/gem_comet/pull/60) Verify git condition on release ([@ryz310](https://github.com/ryz310))

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

* [#32](https://github.com/ryz310/gem_comet/pull/32) Modify to display gem versions sorted by tagged date ([@ryz310](https://github.com/ryz310))
* [#33](https://github.com/ryz310/gem_comet/pull/33) Add the legend to creating pull requests ([@ryz310](https://github.com/ryz310))
* [#36](https://github.com/ryz310/gem_comet/pull/36) Open the GitHub pull request page at release ([@ryz310](https://github.com/ryz310))

### Bugfix

* [#34](https://github.com/ryz310/gem_comet/pull/34) Fix broken links included by the modified change log ([@ryz310](https://github.com/ryz310))

### Breaking Change

* [#35](https://github.com/ryz310/gem_comet/pull/35) Changelog initializer ([@ryz310](https://github.com/ryz310))
    * The `$ gem_comet changelog` command options has changed:
        * Before:
            * `$ gem_comet changelog --from=0.1.0 --to=0.1.1`
        * After:
            * `$ gem_comet changelog --version=v0.1.1`

## v0.3.0 (Oct 19, 2019)

### Feature

* [#27](https://github.com/ryz310/gem_comet/pull/27) Enhance the feature of changelog command ([@ryz310](https://github.com/ryz310))

### Misc

* [#25](https://github.com/ryz310/gem_comet/pull/25) Re-generate .rubocop_todo.yml with RuboCop v0.75.1 ([@ryz310](https://github.com/ryz310))

## v0.2.0 (Oct 13, 2019)

### Feature

* [#22](https://github.com/ryz310/gem_comet/pull/22) Auto generate change log ([@ryz310](https://github.com/ryz310))

## v0.1.1 (Oct 13, 2019)

### Bugfix

* [#16](https://github.com/ryz310/gem_comet/pull/16) Fix version number validation ([@ryz310](https://github.com/ryz310))

### Misc

* [#3](https://github.com/ryz310/gem_comet/pull/3) Re-generate .rubocop_todo.yml with RuboCop v0.73.0 ([@ryz310](https://github.com/ryz310))
* [#5](https://github.com/ryz310/gem_comet/pull/5) Re-generate .rubocop_todo.yml with RuboCop v0.74.0 ([@ryz310](https://github.com/ryz310))
* [#13](https://github.com/ryz310/gem_comet/pull/13) Re-generate .rubocop_todo.yml with RuboCop v0.75.0 ([@ryz310](https://github.com/ryz310))
* [#9](https://github.com/ryz310/gem_comet/pull/9) ryz310/dependabot/bundler/rake-tw-13.0 ([@ryz310](https://github.com/ryz310))
* [#14](https://github.com/ryz310/gem_comet/pull/14) ryz310/dependabot/bundler/rubocop-performance-1.5.0 ([@ryz310](https://github.com/ryz310))
* [#17](https://github.com/ryz310/gem_comet/pull/17) ryz310/dependabot/bundler/rspec-3.9.0 ([@ryz310](https://github.com/ryz310))

## v0.1.0 (Jul 15, 2019)

Initial release :rocket:
