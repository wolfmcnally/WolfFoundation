Pod::Spec.new do |s|
    s.name             = 'WolfFoundation'
    s.version          = '3.0.4'
    s.summary          = 'A variety of types and conveniences built on or extending Foundation.'

    s.homepage         = 'https://github.com/wolfmcnally/WolfFoundation'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'Wolf McNally' => 'wolf@wolfmcnally.com' }
    s.source           = { :git => 'https://github.com/wolfmcnally/WolfFoundation.git', :tag => s.version.to_s }

    s.source_files = 'Sources/WolfFoundation/**/*'

    s.swift_version = '5.0'

    s.ios.deployment_target = '9.3'
    s.macos.deployment_target = '10.13'
    s.tvos.deployment_target = '11.0'

    s.module_name = 'WolfFoundation'

    s.dependency 'WolfNumerics'
    s.dependency 'WolfPipe'
end
