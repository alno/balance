require File.expand_path("../lib/balance/version", __FILE__)

Gem::Specification.new do |s|
  s.name = "balance"
  s.version = Balance::VERSION::STRING
  s.platform = Gem::Platform::RUBY
  s.authors = ["Alexey Noskov"]
  s.email = ["alexey.noskov@gmail.com"]
  s.homepage = "http://github.com/alno/balance"
  s.summary = "Balance is a gem automating checking balance for different service providers."
  s.description = "Balance is a gem automating checking balance for different service providers, such as mobile operators, hosting providers."

  s.required_rubygems_version = ">= 1.3.6"

  # Gem dependencies
  s.add_dependency "mechanize"

  # Gem files
  s.files = Dir["lib/**/*.rb", "bin/*", "MIT-LICENSE", "README.rdoc"]
  s.extra_rdoc_files = [ "README.rdoc", "MIT-LICENSE"]
  s.require_path = 'lib'
  s.executables = ["balance"]

  # Info
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Balance gem", "--main", "README.rdoc"]

end
