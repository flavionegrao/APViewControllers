Pod::Spec.new do |s|
  s.name             = "APViewControllers"
  s.version          = "0.1"
  s.summary          = "Custom View Controllers"
  s.homepage         = "https://github.com/flavionegrao/APViewControllers"
  s.license          = 'MIT'
  s.author           = { "Flavio Negrao Torres" => "flavio@apetis.com" }

  s.source           = { :git => "https://github.com/flavionegrao/APViewControllers.git", :tag => "#{s.version}" }
  s.source_files     = "APViewControllers/**"

  s.ios.deployment_target = '7.1'
  s.requires_arc = true

end

