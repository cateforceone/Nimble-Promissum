Pod::Spec.new do |s|
  s.name         = "Nimble-Promissum"
  s.version      = "0.1.1"
  s.summary      = "Nimble matchers for Promissum promises"
  s.description  = <<-DESC
                   Nimble matchers for Promissum promises. These allow you to easily write expressive tests that produce useful failure messages when working with promises.
                   DESC
  s.homepage     = "https://github.com/briancroom/Nimble-Promissum"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Brian Croom" => "brian.s.croom@gmail.com" }
  s.social_media_url = "http://twitter.com/aikoniv"
  s.platform     = :ios, "9.0"
  s.pod_target_xcconfig = { 'ENABLE_BITCODE' => 'NO' }
  s.source       = { :git => "https://github.com/briancroom/Nimble-Promissum.git", :tag => s.version }
  s.source_files = "Nimble-Promissum/*.swift"
  s.requires_arc = true
  s.frameworks   = "Foundation", "XCTest"
  s.dependency "Promissum", "~> 1.0.0"
  s.dependency "Nimble"
  s.dependency "Quick"
end
