$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "martian_components/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "martian_components"
  s.version     = MartianComponents::VERSION
  s.authors     = ["Theo B"]
  s.email       = ["mail@theob.me"]
  s.homepage    = "http://github.com/polomarte/martian_components"
  s.summary     = "Web components with admin modules."
  s.description = ""
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency('rails', ['>= 4.1.0'])
  s.add_dependency('bootstrap-sass', ['~> 3.2.0'])
  s.add_dependency('rails_autolink', ['~> 1.1.0'])
  s.add_dependency('koala', ['~> 2.2.0'])
  s.add_dependency('twitter', ['~> 5.15.0'])

  s.add_development_dependency 'sqlite3'
end
