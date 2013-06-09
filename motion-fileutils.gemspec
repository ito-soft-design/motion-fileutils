# -*- encoding: utf-8 -*-
VERSION = "0.1"

Gem::Specification.new do |spec|
  spec.name          = "motion-fileutils"
  spec.version       = VERSION
  spec.authors       = ["Katsuyoshi Ito"]
  spec.email         = ["kito@itosoft.com"]
  spec.description   = %q{ FileUtils for RubyMotion. }
  spec.summary       = %q{ The aim is to implement methods in Ruby FileUtils. }
  spec.homepage      = ""
  spec.license       = "MIT"

  files = []
  files << 'README.md'
  files << 'LICENSE'
  files.concat(Dir.glob('lib/**/*.rb'))
  spec.files         = files
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake"
end
