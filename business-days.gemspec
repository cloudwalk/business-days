Gem::Specification.new do |s|
  s.name        = 'business-days'
  s.version     = '1.0.0'
  s.date        = '2018-03-02'
  s.summary     = "Business Days"
  s.description = "Methods to check if a given date is a business days and to perform computations based on Business days."
  s.authors     = ["Allan Costa"]
  s.email       = 'allan@cloudwalk.io'
  s.files       = ["lib/business-days.rb"]
  s.homepage    = 'http://rubygems.org/gems/business-days'
  s.license     = 'MIT'
  s.add_dependency "activesupport", '~> 5.1'
  s.add_dependency "tzinfo", '= 1.2.2'
  s.add_dependency "tzinfo-data", '= 1.2017.2'
  s.add_dependency "holidays", '= 5.4.0'
  s.metadata = {
    "changelog_uri"     => "https://github.com/cloudwalkio/business-days/blob/master/CHANGELOG.md",
    "documentation_uri" => "http://www.rubydoc.info/github/cloudwalkio/business-days",
    "source_code_uri"   => "https://github.com/cloudwalkio/business-days"
  }
end
