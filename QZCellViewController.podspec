Pod::Spec.new do |s|
s.name             = "QZCellViewController"    #名称
s.version          = "1.0.0"             #版本号
s.summary          = "Just Testing."
s.description      = <<-DESC
Testing Private Podspec.
* Markdown format.
* Don't worry about the indent, we strip it!
DESC

s.homepage         = "https://github.com/cxy921126/CellControl"    #主页
s.license          = 'MIT'              #开源协议
s.author           = { "cxy921126" => "286193150@qq.com" }                   #作者信息
s.source           = { :git => "https://github.com/cxy921126/CellControl.git", :tag => "1.0.0" }         #项目地址
s.platform     = :ios, '7.0'            #支持的平台及版本
s.requires_arc = true                   #是否使用ARC，如果指定具体文件，则具体的问题使用ARC
s.source_files = 'Pod/**/*'     #代码源文件地址，**/*表示Classes目录及其子目录下所有文件，如果有多个目录下则用逗号分开，如果需要在项目中分组显示，这里也要做相应的设置
s.frameworks = 'UIKit'                  #所需的framework，多个用逗号隔开
end