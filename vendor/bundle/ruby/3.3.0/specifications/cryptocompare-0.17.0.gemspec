# -*- encoding: utf-8 -*-
# stub: cryptocompare 0.17.0 ruby lib

Gem::Specification.new do |s|
  s.name = "cryptocompare".freeze
  s.version = "0.17.0".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "allowed_push_host" => "https://rubygems.org" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Alexander David Pan".freeze]
  s.bindir = "exe".freeze
  s.date = "2021-11-25"
  s.description = "A Ruby gem for communicating with the CryptoCompare API".freeze
  s.email = ["alexanderdavidpan@gmail.com".freeze]
  s.homepage = "https://github.com/alexanderdavidpan/cryptocompare".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.3.0".freeze)
  s.rubygems_version = "3.1.2".freeze
  s.summary = "A Ruby gem for communicating with the CryptoCompare API".freeze

  s.installed_by_version = "3.5.16".freeze if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_development_dependency(%q<bundler>.freeze, ["~> 2.2.0".freeze])
  s.add_development_dependency(%q<rake>.freeze, [">= 12.3.3".freeze])
  s.add_development_dependency(%q<minitest>.freeze, ["~> 5.0".freeze])
  s.add_development_dependency(%q<vcr>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<webmock>.freeze, [">= 0".freeze])
  s.add_runtime_dependency(%q<faraday>.freeze, [">= 0".freeze])
  s.add_runtime_dependency(%q<json>.freeze, [">= 0".freeze])
end
