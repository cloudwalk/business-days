Gem::Specification.new do |s|
  s.name        = 'business-days'
  s.version     = '4.2.1'
  s.date        = '2021-02-04'
  s.summary     = "Business Days"
  s.description = "Methods to check if a given date is a business days and to perform computations based on Business days."
  s.authors     = ["Allan Costa"]
  s.email       = 'allan@cloudwalk.io'
  s.files       = ["lib/business-days.rb"]
  s.homepage    = 'http://rubygems.org/gems/business-days'
  s.license     = 'MIT'
  s.add_dependency "activesupport"
  s.add_dependency "tzinfo", '~> 2.0'
  s.add_dependency "tzinfo-data", '~> 1'
  s.add_dependency "holidays", '~> 8.8'
  s.metadata = {
    "changelog_uri"     => "https://github.com/cloudwalkio/business-days/blob/master/CHANGELOG.md",
    "documentation_uri" => "http://www.rubydoc.info/github/cloudwalkio/business-days",
    "source_code_uri"   => "https://github.com/cloudwalkio/business-days"
  }
end
