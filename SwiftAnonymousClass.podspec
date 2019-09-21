Pod::Spec.new do |s|
  s.name = 'SwiftAnonymousClass'
  s.version = '1.0.0'
  s.license = 'MIT'
  s.summary = 'Anonymous class for Swift'
  s.homepage = 'https://github.com/smakeev/SwiftWhen'
  s.authors = { 'Sergey Makeev' => 'makeev.87@gmaol.com' }
  s.source = { :git => 'https://github.com/smakeev/SwiftAnonymousClass.git', :tag => s.version }
  s.documentation_url = 'https://github.com/smakeev/SwiftAnonymousClass/blob/master/README.md'

  s.ios.deployment_target = '10.0'
  s.osx.deployment_target = '10.12'
  s.tvos.deployment_target = '10.0'
  s.watchos.deployment_target = '3.0'

  s.swift_versions = ['5.0', '5.1']

  s.source_files = 'Source/*.swift'
end
