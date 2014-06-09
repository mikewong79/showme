# -*- encoding: utf-8 -*-
# stub: rdio_api 0.1.1 ruby lib

Gem::Specification.new do |s|
  s.name = "rdio_api"
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Anil Varanasi"]
  s.date = "2012-09-15"
  s.description = "A Ruby wrapper for the Rdio API"
  s.email = ["anil@anilv.com"]
  s.homepage = "http://github.com/anilv/rdio_api"
  s.rubygems_version = "2.2.2"
  s.summary = "A Ruby wrapper for the Rdio API"

  s.installed_by_version = "2.2.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>, ["~> 0.9"])
      s.add_development_dependency(%q<rspec>, ["~> 2.6"])
      s.add_development_dependency(%q<webmock>, ["~> 1.6"])
      s.add_development_dependency(%q<oauth>, ["~> 0.4.5"])
      s.add_development_dependency(%q<rb-fsevent>, [">= 0"])
      s.add_development_dependency(%q<guard-rspec>, [">= 0"])
      s.add_runtime_dependency(%q<faraday>, ["~> 0.8.0"])
      s.add_runtime_dependency(%q<faraday_middleware>, ["~> 0.8.7"])
      s.add_runtime_dependency(%q<hashie>, ["~> 1.2.0"])
      s.add_runtime_dependency(%q<multi_json>, ["~> 1.3.0"])
      s.add_runtime_dependency(%q<simple_oauth>, ["~> 0.1.5"])
    else
      s.add_dependency(%q<rake>, ["~> 0.9"])
      s.add_dependency(%q<rspec>, ["~> 2.6"])
      s.add_dependency(%q<webmock>, ["~> 1.6"])
      s.add_dependency(%q<oauth>, ["~> 0.4.5"])
      s.add_dependency(%q<rb-fsevent>, [">= 0"])
      s.add_dependency(%q<guard-rspec>, [">= 0"])
      s.add_dependency(%q<faraday>, ["~> 0.8.0"])
      s.add_dependency(%q<faraday_middleware>, ["~> 0.8.7"])
      s.add_dependency(%q<hashie>, ["~> 1.2.0"])
      s.add_dependency(%q<multi_json>, ["~> 1.3.0"])
      s.add_dependency(%q<simple_oauth>, ["~> 0.1.5"])
    end
  else
    s.add_dependency(%q<rake>, ["~> 0.9"])
    s.add_dependency(%q<rspec>, ["~> 2.6"])
    s.add_dependency(%q<webmock>, ["~> 1.6"])
    s.add_dependency(%q<oauth>, ["~> 0.4.5"])
    s.add_dependency(%q<rb-fsevent>, [">= 0"])
    s.add_dependency(%q<guard-rspec>, [">= 0"])
    s.add_dependency(%q<faraday>, ["~> 0.8.0"])
    s.add_dependency(%q<faraday_middleware>, ["~> 0.8.7"])
    s.add_dependency(%q<hashie>, ["~> 1.2.0"])
    s.add_dependency(%q<multi_json>, ["~> 1.3.0"])
    s.add_dependency(%q<simple_oauth>, ["~> 0.1.5"])
  end
end
