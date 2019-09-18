Pod::Spec.new do |s|
  s.name             = 'Zama'
  s.version          = '0.1.0'
  s.summary          = 'Zamazenta, a pokemon to protect app from crash.'
  s.description      = <<-DESC
Zamazenta is a pokemon, let's get it and protect our app from crashing!
                       DESC

  s.homepage         = 'https://github.com/leon4app/Zama'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Leon' => 'leon4w@outlook.com' }
  s.source           = { :git => 'https://github.com/leon4app/Zama.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = 'Zama/Classes/**/*'
  s.public_header_files = 'Zama/Classes/Zama.h'
  s.test_spec 'Tests' do |test_spec|
      test_spec.source_files = 'Zama/Tests/**/*'
  end

  s.pod_target_xcconfig = {
    'CLANG_WARN_STRICT_PROTOTYPES' => 'NO',
  }
end
