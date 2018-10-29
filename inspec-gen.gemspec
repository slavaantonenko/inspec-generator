Gem::Specification.new do |gem|
  gem.authors       = ["Slava Antonenko","Liat Bendelac","Alon Antoshvinski"]
  gem.email         = ["slava640@gmail.com","liatbendelac@gmail.com","alon_a1985@hotmail.com"]
  gem.description   = %q{Creates Inspec code from Chef}
  gem.summary       = %q{Inspec code generator}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| ::File.basename(f) }
  gem.name          = 'inspec-gen'
  gem.require_paths = ["lib"]
  gem.version       = '2.0.0'
end
