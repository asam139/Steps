Pod::Spec.new do |s|
  s.name             = 'Steps'
  s.version          = '0.3.1'
  s.summary          = 'Steps is a navigation bar that guides users through the steps of a task.'
  s.description      = <<-DESC
Steps is a navigation bar that guides users through the steps of a task. You need to use it when a given task is complicated or has a certain sequence in the series of subtasks, we can decompose it into several steps to make things easier.
                       DESC

  s.homepage         = 'https://github.com/asam139/Steps'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'asam139' => '93sauu@gmail.com' }
  s.screenshot = 'https://raw.githubusercontent.com/asam139/Steps/master/Assets/logo.png'

  s.ios.deployment_target = '13.0'
  s.osx.deployment_target = '10.15'
  s.tvos.deployment_target = '13.0'

  s.swift_version = '5.1'
  s.source = { :git => 'https://github.com/asam139/Steps.git', :tag => s.version.to_s }
  s.source_files = 'Sources/Steps/**/*'
  
  s.frameworks = 'SwiftUI', 'Combine'
  s.dependency 'SwifterSwiftUI', '~> 0.4.0'
end
