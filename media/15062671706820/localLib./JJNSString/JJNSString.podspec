Pod::Spec.new do |s|

s.name         = "JJNSString" # 项目名称
s.version      = "0.0.1" # 版本号 与 你仓库的 标签号 对应
s.summary      = "JJNSString."  # 项目简介


s.description  = "JJNSString分类, 后期添加工具类"
s.homepage     = "http://EXAMPLE/XMGFMBase"


s.license      = "MIT" # 开源证书

s.author             = { "JJAdobe" => "271584255@qq.com" } # 作者信息

# s.platform     = :ios
# s.platform     = :ios, "5.0"

s.source       = { :git => "", :tag => "#{s.version}" } #你的仓库地址 本地这里为空

s.source_files  = "Classes", "Classes/**/*.{h,m}" # 你代码的位置
#s.exclude_files = "Classes/Exclude"

# s.public_header_files = "Classes/**/*.h"

end


