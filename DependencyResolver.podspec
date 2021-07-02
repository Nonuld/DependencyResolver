Pod::Spec.new do |spec|
    spec.name          = 'DependencyResolver'
    spec.version       = '0.1.0'
    spec.license       = { :type => 'MIT', :file => 'LICENSE' }
    spec.homepage      = 'https://github.com/Nonuld/DependencyResolver'
    spec.authors       = { 'Arnaud Le Bourblanc' => '' }
    spec.summary       = 'A basic Swift library that provides dependency injection.'
    spec.source        = { :git => 'https://github.com/Nonuld/DependencyResolver.git', :tag => spec.version.to_s }
    spec.swift_version = '5.4'

    spec.ios.deployment_target  = '13.0'

    spec.source_files       = 'Sources/DependencyResolver/*.swift'
end
