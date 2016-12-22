

Pod::Spec.new do |s|

  s.name         = "SwitchHost"

  s.version      = "1.0.2.swift-version"

  s.summary      = "a simple viewController for siwtch hosts"

  s.description  = <<-DESC
  a simple viewController for siwtch hosts.
  DESC

  s.homepage     = "https://github.com/TieShanWang/SwitchHost"

  s.license      = "MIT"

  s.author             = { "wangtieshan" => "15003836653@163.com" }

  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/TieShanWang/SwitchHost.git", :tag => "1.0.2.swift-version" }

  s.source_files  = "SwitchHost/SwitchHost/**/*.{swift}"

  s.framework  = "UIKit"

 s.requires_arc = true

end
