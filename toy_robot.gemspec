# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'toy_robot/version'

Gem::Specification.new do |gem|
  gem.name          = "toy_robot"
  gem.version       = ToyRobot::VERSION
  gem.authors       = ["Tarcio Saraiva"]
  gem.email         = ["tarcio@gmail.com"]
  gem.description   = %q{The Toy Robot}
  gem.summary       = %q{A simple toy robot that moves around in a board}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
