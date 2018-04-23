
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "symbol_serializer/version"

Gem::Specification.new do |spec|
  spec.name          = "symbol_serializer"
  spec.version       = SymbolSerializer::VERSION
  spec.authors       = ["Yash Doshi", "Anuj Khandelwal"]
  spec.email         = ["yash@bizongo.in", "khandelwal.anuj14@gmail.com"]

  spec.summary       = %q{Contains a library which enables us to serialize and deserialize data}
  spec.description   = %q{Contains a concern that allows us to serialize all the values before passing them to Sidekiq and deserialize them before Sidekiq operates on them}
  spec.homepage      = "https://bizongo.in"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", ">= 1.15.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "activesupport"
end
