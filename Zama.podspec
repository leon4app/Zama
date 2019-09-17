Pod::Spec.new do |s|
  s.name             = 'Zama'
  s.version          = '0.1.0'
  s.summary          = 'Zamazenta, a pokemon to protect app from crash.'
  s.description      = <<-DESC
Zamazenta is a pokemon, let's get it and protect our app from crashing!
                       DESC

  s.homepage         = 'https://github.com/leon4app/Zama'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'leon4app' => 'leon4w@outlook.com' }
  s.source           = { :git => 'https://github.com/leon4app/Zama.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = 'Zama/Classes/**/*'
end
