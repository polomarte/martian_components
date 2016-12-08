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
  s.add_dependency('devise', ['~> 3.5.10'])
  s.add_dependency('bootstrap-sass', ['~> 3.2'])
  s.add_dependency('rails_autolink', ['~> 1.1.0'])
  s.add_dependency('koala', ['~> 2.2.0'])
  s.add_dependency('twitter', ['~> 5.15.0'])
  s.add_dependency('pg_search', ['~> 1.0.5'])
  s.add_dependency('slim-rails', ['~> 3.0.1'])
  s.add_dependency('carrierwave', ['~> 0.10.0'])
  s.add_dependency('mini_magick', ['~> 4.3.2'])
  s.add_dependency('globalize', ['~> 5.0.1'])
  s.add_dependency('activeadmin', ['1.0.0.pre2'])
  s.add_dependency('pundit', ['~>1.0.1'])
  s.add_dependency('draper', ['~>1.4.0'])
  s.add_dependency('bourbon', ['~>3.2.3'])
  s.add_dependency('turbolinks', ['~>2.5.3'])
  s.add_dependency('s3_file_field', ['~>1.3.0'])
  s.add_dependency('cocoon', ['~>1.2.6'])
  s.add_dependency('inline_svg', ['~>0.6.1'])

  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'pry'
end
