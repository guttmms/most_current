# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{postgres-pr}
  s.version = "0.6.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Michael Neumann"]
  s.date = %q{2009-12-14}
  s.email = %q{mneumann@ntecs.de}
  s.homepage = %q{http://postgres-pr.rubyforge.org}
  s.require_paths = ["lib"]
  s.requirements = ["PostgreSQL >= 7.4"]
  s.rubyforge_project = %q{postgres-pr}
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{A pure Ruby interface to the PostgreSQL (>= 7.4) database}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
