Pod::Spec.new do |s|
  s.name         = 'Tango'
  s.version      = '1.0.0'
  s.summary      = 'Tango iOS SDK'
  s.author       = { 'Tango Targeting Inc.' => 'dev@tangotargeting.com' }
  s.homepage     = 'http://www.tangotargeting.com'   
  s.license 	 = {:type => 'COMMERCIAL', :file => 'LICENSE.txt'}
  s.platform     = :ios, '8.0'
#TODO: add tag for repo 
  s.source       = { :git => 'https://bitbucket.org/tango-team/tango-ios-sample.git' }
  s.resources    = 'Tango.bundle'
  s.frameworks   = 'SystemConfiguration', 'UIKit', 'Foundation', 'CoreGraphics', 'CoreLocation'
  s.vendored_frameworks = 'Tango.framework'
  s.xcconfig = { 'FRAMEWORK_SEARCH_PATHS' => '"$(PODS_ROOT)/Tango"' }

end
