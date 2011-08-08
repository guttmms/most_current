# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{linkedin}
  s.version = "0.2.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Wynn Netherland", "Josh Kalderimis"]
  s.date = %q{2010-02-28}
  s.description = %q{Ruby wrapper for the LinkedIn API}
  s.email = ["wynn.netherland@gmail.com", "josh.kalderimis@gmail.com"]
  s.files = ["spec/cases/client_spec.rb", "spec/cases/linkedin_spec.rb", "spec/cases/oauth_spec.rb", "spec/fixtures/blank.xml", "spec/fixtures/connections.xml", "spec/fixtures/error.xml", "spec/fixtures/likes.xml", "spec/fixtures/mailbox_items.xml", "spec/fixtures/network_status_with_group.xml", "spec/fixtures/network_statuses.xml", "spec/fixtures/picture_updates.xml", "spec/fixtures/profile.xml", "spec/fixtures/profile_full.xml", "spec/fixtures/profile_with_positions.xml", "spec/fixtures/search.xml", "spec/fixtures/shares.xml", "spec/fixtures/status.xml", "spec/spec_helper.rb"]
  s.homepage = %q{http://github.com/pengwynn/linkedin}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{Ruby wrapper for the LinkedIn API}
  s.test_files = ["spec/cases/client_spec.rb", "spec/cases/linkedin_spec.rb", "spec/cases/oauth_spec.rb", "spec/fixtures/blank.xml", "spec/fixtures/connections.xml", "spec/fixtures/error.xml", "spec/fixtures/likes.xml", "spec/fixtures/mailbox_items.xml", "spec/fixtures/network_status_with_group.xml", "spec/fixtures/network_statuses.xml", "spec/fixtures/picture_updates.xml", "spec/fixtures/profile.xml", "spec/fixtures/profile_full.xml", "spec/fixtures/profile_with_positions.xml", "spec/fixtures/search.xml", "spec/fixtures/shares.xml", "spec/fixtures/status.xml", "spec/spec_helper.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<oauth>, ["~> 0.4.0"])
      s.add_runtime_dependency(%q<nokogiri>, ["~> 1.4.4"])
      s.add_development_dependency(%q<rspec>, ["~> 2.4.0"])
      s.add_development_dependency(%q<rake>, ["~> 0.8.7"])
      s.add_development_dependency(%q<webmock>, ["~> 1.6.0"])
    else
      s.add_dependency(%q<oauth>, ["~> 0.4.0"])
      s.add_dependency(%q<nokogiri>, ["~> 1.4.4"])
      s.add_dependency(%q<rspec>, ["~> 2.4.0"])
      s.add_dependency(%q<rake>, ["~> 0.8.7"])
      s.add_dependency(%q<webmock>, ["~> 1.6.0"])
    end
  else
    s.add_dependency(%q<oauth>, ["~> 0.4.0"])
    s.add_dependency(%q<nokogiri>, ["~> 1.4.4"])
    s.add_dependency(%q<rspec>, ["~> 2.4.0"])
    s.add_dependency(%q<rake>, ["~> 0.8.7"])
    s.add_dependency(%q<webmock>, ["~> 1.6.0"])
  end
end
