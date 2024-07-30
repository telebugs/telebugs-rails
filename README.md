# Telebugs for Rails

Simple error monitoring for developers. Monitor production errors in real-time
and get them reported to Telegram with Telebugs.

- [Official Documentation](https://telebugs.com/docs/integrations/rails)
- [FAQ](https://telebugs.com/faq)
- [Telebugs News](https://t.me/TelebugsNews)
- [Telebugs Community](https://t.me/TelebugsCommunity)

## Introduction

Any Ruby on Rails application can be integrated with
[Telebugs](https://telebugs.com) using the `telebugs-rails` gem. The gem is
designed to be simple and easy to use. It integrates the `telebugs` gem with
Rails application, so that any unhandled error occurring in your app will be
reported to Telebugs.

## Installation

For the integration details, please refer to the
[Telebugs documentation](https://telebugs.com/docs/integrations/rails).

## Rails support policy

Telebugs for Rails supports the following Rails versions:

- Rails 6.1+

If you need support older Rails versions, please contact us at
[help@telebugs.com](mailto:help@telebugs.com).

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kyrylo/telebugs-rails.
