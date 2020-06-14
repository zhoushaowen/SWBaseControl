Pod::Spec.new do |s|

  s.name         = "SWBaseControl"

  s.version      = "1.6"

  s.homepage      = 'https://github.com/zhoushaowen/SWBaseControl'

  s.ios.deployment_target = '8.0'

  s.summary      = "a control group"

  s.license      = { :type => 'MIT', :file => 'LICENSE' }

  s.author       = { "Zhoushaowen" => "348345883@qq.com" }

  s.source       = { :git => "https://github.com/zhoushaowen/SWBaseControl.git", :tag => s.version }
  
  s.resource  = "SWBaseControl/SWBaseControl/Source/*"
  
  s.dependency 'SWCustomPresentation'

  s.dependency 'SWMultipleDelegateProxy'

  s.dependency 'SWExtension/Core'

  s.dependency 'ReactiveObjC'

  s.dependency 'MJExtension'

  s.dependency 'DZNEmptyDataSet'
  
  s.requires_arc = true

  s.subspec 'SWPopover' do |ss|

  ss.source_files = "SWBaseControl/SWBaseControl/SWPopover/*.{h,m}"

  end

  s.subspec 'SWBaseViewController' do |ss|

  ss.source_files = "SWBaseControl/SWBaseControl/SWBaseViewController/*.{h,m}"

  end

  s.subspec 'Other' do |ss|

  ss.source_files = "SWBaseControl/SWBaseControl/Other/*.{h,m}"

  end

end
