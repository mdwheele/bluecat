# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bluecat/version'

Gem::Specification.new do |spec|
  spec.name          = "bluecat"
  spec.version       = Bluecat::VERSION
  spec.authors       = ["Dustin Wheeler"]
  spec.email         = ["mdwheele@ncsu.edu"]

  spec.summary       = %q{Bluecat Address Management Client}
  spec.description   = %q{Use this gem to interact with the Bluecat Address Management SOAP API}
  spec.homepage      = "https://github.com/mdwheele/bluecat"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'thor', '~> 0.19'
  spec.add_dependency 'savon', '~> 2.11'

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
