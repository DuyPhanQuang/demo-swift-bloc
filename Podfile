# Uncomment the next line to define a global platform for your project
platform :ios, '13.2'

workspace 'demo-swift-bloc.xcworkspace'

target 'demo-swift-bloc' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for demo-swift-bloc
  
  target 'demo-swift-bloc' do
    project 'demo-swift-bloc.xcodeproj'
    
    pod 'Kingfisher', :git => 'https://github.com/onevcat/Kingfisher.git'
    pod 'SwiftBloc', :git => 'https://github.com/DuyPhanQuang/SwiftBloc.git'
    pod 'SwiftUIRefresh', :git => 'https://github.com/timbersoftware/SwiftUIRefresh.git'
  end

  target 'demo-swift-blocTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'MockingbirdFramework', '~> 0.18'
    pod 'SwiftBloc', :git => 'https://github.com/DuyPhanQuang/SwiftBloc.git'
  end

  target 'demo-swift-blocUITests' do
    # Pods for testing
  end

  target 'RepositoryTests' do
    project 'Repository/Repository.xcodeproj'

    pod 'MockingbirdFramework', '~> 0.18'
  end

end

