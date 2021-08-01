# Uncomment the next line to define a global platform for your project
platform :ios, '14.0'

workspace 'GitHub Client.xcworkspace'
project 'GitHub Client.xcodeproj'

def networking_pod
  pod 'Networking', :path => 'DevPods/Networking'
end

def development_pods
  networking_pod
end

target 'GitHub Client' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for app
  development_pods
  
  # Pods for GitHub Client
    pod 'SwiftLint'
end

target 'Networking_Example' do
  use_frameworks!
  project 'DevPods/Networking/Example/Networking.xcodeproj'
  
  networking_pod
end
