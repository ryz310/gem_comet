[![CircleCI](https://circleci.com/gh/ryz310/gem_comet.svg?style=svg)](https://circleci.com/gh/ryz310/gem_comet) [![Gem Version](https://badge.fury.io/rb/gem_comet.svg)](https://badge.fury.io/rb/gem_comet) [![Maintainability](https://api.codeclimate.com/v1/badges/bf80edef201ffe5f3c67/maintainability)](https://codeclimate.com/github/ryz310/gem_comet/maintainability) [![Test Coverage](https://api.codeclimate.com/v1/badges/bf80edef201ffe5f3c67/test_coverage)](https://codeclimate.com/github/ryz310/gem_comet/test_coverage)

# GemComet

The `gem_comet` is a command line tool which to update and release your gem.
Install as following:

```
$ gem install 'gem_comet'
```

Initialize `gem_comet` as following:

```
$ gem_comet init
```

Then, edit the created file: `.gem_comet.yml` as following.

```yaml
version: 1

release:
  base_branch: master
  release_branch: release
  version_file_path: { Path of the version file. e.g. lib/gem_comet/version.rb }
```

## Usage

```
$ gem_comet release { The version number you want to release. e.g. "1.2.3" }
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/gem_comet. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the GemComet project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/gem_comet/blob/master/CODE_OF_CONDUCT.md).
