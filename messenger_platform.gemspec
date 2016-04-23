$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "messenger_platform/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "messenger_platform"
  s.version     = MessengerPlatform::VERSION
  s.authors     = ["Jaryl Sim"]
  s.email       = ["jaryl@tinkerbox.com.sg"]
  s.homepage    = "https://github.com/tinkerbox/messenger_platform"
  s.summary     = "Integrate Facebook's messenger platform with your rails app"
  s.description = "MessengerPlatform includes a mountable engine to process webhooks, and an API wrapper to talk to Facebook."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 4.2"
  s.add_dependency "faraday", "~> 0"

  s.add_development_dependency "rspec-rails", "~> 3.4"
  s.add_development_dependency "sqlite3", "~> 1.3"
  s.add_development_dependency "codeclimate-test-reporter", "~> 0"
  s.add_development_dependency "dotenv", "~> 2.1"
  s.add_development_dependency "pry", "~> 0"
end
