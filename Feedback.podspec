Pod::Spec.new do |s|
  s.name             = 'Feedback'
  s.version          = '0.1'
  s.summary          = 'Feedback'

  s.description      = 'Lorem Lipsum'
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.homepage         = 'https://github.com/dgyesbreghs/ios-feedback'
  s.author           = { 'Dylan Gyesbreghs' => 'dgyesbreghs@gmail.com' }
  s.source           = {
    git: 'https://github.com/dgyesbreghs/ios-feedback.git',
    tag: s.version.to_s
  }
  s.social_media_url = 'https://twitter.com/dylangyesbreghs'

  s.dependency 'PureLayout'

  s.ios.deployment_target     = '8.0'
  s.requires_arc = true
  s.source_files = 'Sources/**/*'

end
