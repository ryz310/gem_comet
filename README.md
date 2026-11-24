[![CI](https://github.com/ryz310/gem_comet/actions/workflows/ci.yml/badge.svg)](https://github.com/ryz310/gem_comet/actions/workflows/ci.yml) [![Gem Version](https://badge.fury.io/rb/gem_comet.svg)](https://badge.fury.io/rb/gem_comet)

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

## Supported versions

* Ruby 3.3, 3.4, and 4.0

## Usage

### Display changelogs

Displays changelogs from last release to HEAD commit.

```
$ gem_comet changelog
```

### Release

Creates update PR and release PR.

```
$ gem_comet release { The version number you want to release. e.g. "1.2.3" }
```

Then, you should check pull requests on your GitHub repository page. You will see two pull requests: "Update v1.2.3" and "Release v1.2.3". First, you should check "Update v1.2.3" and merge. Next, you should check "Release v1.2.3" and merge. The "Release v1.2.3" destination is the release branch. You should set up CI that to deploy the gem automatically.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/gem_comet. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the GemComet project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/gem_comet/blob/master/CODE_OF_CONDUCT.md).

## CI and publishing

GitHub Actions dependencies are tracked in `.github/workflows/actions.lock`. After changing a workflow's `uses:` references, run `gh actions-lock` and commit the generated lockfile with the workflow. Dependabot updates locked Actions dependencies together with their references.

GitHub Actions runs RSpec and builds the gem on the supported Ruby versions. It also runs RuboCop, generates YARD docs, and saves merged coverage as a workflow artifact. To publish the report and view maintainability in Qlty, import the repository into Qlty Cloud and set `QLTY_COVERAGE_TOKEN` as an Actions secret. Fork PRs and runs without the secret retain the artifact without publishing.

Automatic publishing is opt-in via `GHA_RELEASE_ENABLED=true` and uses RubyGems Trusted Publishing for `release.yml`. Configure the GitHub `release` environment to allow deployments from the `release` branch only, and associate the RubyGems Trusted Publisher with that environment.

The daily RuboCop Challenge is opt-in via `GHA_CHALLENGE_ENABLED=true`. Before enabling it, install a GitHub App on this repository with Contents and Pull requests write permissions. Set `CHALLENGE_APP_CLIENT_ID` as a repository variable and `CHALLENGE_APP_PRIVATE_KEY` as an Actions secret. The App token lets the challenge PR trigger CI without relying on approval of a PR created by the built-in token.
