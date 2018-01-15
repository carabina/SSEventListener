Pod::Spec.new do |s|
  s.name         = "SSEventListener"
  s.version      = "0.0.1"
  s.ios.deployment_target = '8.0'
  s.summary      = "Simplest way to listen to device shake event, application lifecycle events, view gestures, button tap event with blocks!"
  s.homepage     = "https://github.com/ZhouShengsheng/SSEventListener"
  s.license      = "MIT"
  s.author       = { "Zhou Shengsheng" => "szhou006@e.ntu.edu.sg" }
  s.social_media_url   = "https://www.zhihu.com/people/zhoushengsheng-74"
  s.source       = { :git => "https://github.com/ZhouShengsheng/SSEventListener", :tag => s.version }
  s.source_files = "SSEventListener"
  s.requires_arc = true
end
