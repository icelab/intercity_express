lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "intercity_express/version"

Gem::Specification.new do |gem|
  gem.name          = "intercity_express"
  gem.version       = IntercityExpress::VERSION
  gem.authors       = ["Tim Riley"]
  gem.email         = ["tim@icelab.com.au"]
  gem.summary       = "A collection of helpful utilities for Rails projects."
  gem.description   = "A collection of helpful utilities for Rails projects."
  gem.homepage      = "http://github.com/icelab/intercity_express"
  gem.license       = "MIT"
  gem.files         = Dir["README.md", "lib/**/*"]

  gem.add_dependency "rails", ">= 4.2.0"
  gem.add_dependency "funkify", "~> 0.0"
  gem.add_dependency "redcarpet", "~> 3.3"

  gem.add_development_dependency "bundler", "~> 1.7"
  gem.add_development_dependency "rake", "~> 10.0"
  gem.add_development_dependency "rspec", "~> 3.3.0"
  gem.add_development_dependency "rubocop", "~> 0.33.0"
  gem.add_development_dependency "simplecov", "~> 0.10.0"
end
