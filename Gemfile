source "https://rubygems.org"

# Declare your gem's dependencies in martian_components.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use debugger
# gem 'debugger'

# rspec gem
gem "rspec-rails", '~> 3.5',:group => [:test, :development]
group :development, :test do
  gem "factory_girl_rails"
  gem "capybara"
  gem "guard-rspec"
  gem 'rspec-rails', '~> 3.5'
end


# TODO: Add in .gemspec
gem 'activeadmin-wysihtml5', github: 'theo-bittencourt/activeadmin-wysihtml5'
