Pod::Spec.new do |s|
s.name                  = 'ServerAPI'
s.version               = '1.0.8'
s.summary               = 'A  Web Service Framework   '
s.homepage              = 'https://github.com/heroims/ServerAPI'
s.license               = { :type => 'MIT', :file => 'README.md' }
s.author                = { 'heroims' => 'heroims@163.com' }
s.source                = { :git => 'https://github.com/heroims/ServerAPI.git', :tag => "#{s.version}" }
s.platform              = :ios, '7.0'
s.source_files          = 'ServerAPI/*.{h,m}'
s.requires_arc          = true
end
