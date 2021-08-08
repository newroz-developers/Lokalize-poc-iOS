Pod::Spec.new do |s|
  s.name             = 'LocalizeFramework'
  s.version          = '0.1.6'
  s.summary          = 'SDK for interfacing multiple languages using localize key APIs.'

  s.description      = <<-DESC
LocalizeFramework is quickest, most convenient, and safest way to integrate multiple languages supports in your app .
                       DESC

  s.homepage         = 'https://github.com/newroz-developers/Lokalize-poc-iOS'
  s.license          = { :type => 'Apache v2', :file => 'LICENSE' }
  
  s.author           = { 'Fastpay' => 'rakib@newroztech.com' }
  s.source           = { :http => 'https://vasantor.com/libs/ios/LocalizeFramework.zip' }

  s.ios.deployment_target = '11.0'
  s.swift_version = "5.0"
  s.source_files = 'LocalizeFramework/*'
  s.exclude_files = 'LocalizeFramework/*.plist'

end