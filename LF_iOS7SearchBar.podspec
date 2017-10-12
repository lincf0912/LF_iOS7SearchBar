Pod::Spec.new do |s|
s.name         = 'LF_iOS7SearchBar'
s.version      = '1.0.3'
s.summary      = 'LF_iOS7SearchBar, Custom SearchBar like iOS7\'s UISearchBar'
s.homepage     = 'https://github.com/lincf0912/LF_iOS7SearchBar'
s.license      = 'MIT'
s.author       = { 'lincf0912' => 'dayflyking@163.com' }
s.platform     = :ios
s.ios.deployment_target = '7.0'
s.source       = { :git => 'https://github.com/lincf0912/LF_iOS7SearchBar.git', :tag => s.version, :submodules => true }
s.requires_arc = true
s.resources    = 'LF_iOS7SearchBar/class/*.bundle'
s.source_files = 'LF_iOS7SearchBar/class/*.{h,m}'
s.public_header_files = 'LF_iOS7SearchBar/class/*.h'

end
