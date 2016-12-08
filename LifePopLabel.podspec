Pod::Spec.new do |spec|
    spec.name                  = 'LifePopLabel'
    spec.version               = '1.0.0'
    spec.summary               = 'Implements a pop style view.'

    spec.description           = <<-DESC
                               A pop style view, you can custom its border, fill color, arrow position, arrow angle and height, adding text. And its height will be caculated automatically.
                               DESC

    spec.homepage              = 'https://github.com/pgbo/LifePopLabel.git'
    spec.license               = { :type => 'MIT', :file => 'LICENSE' }
    spec.author                = { 'guangbool' => '460667915@qq.com' }
    spec.social_media_url      = 'https://twitter.com/guangbool'
    spec.platform              = :ios, '7.0'
    spec.source                = { :git => 'https://github.com/pgbo/LifePopLabel.git', :tag => spec.version }
    spec.source_files          = 'Classes/*.{h,m}'
    spec.requires_arc          = true
    spec.frameworks            = 'UIKit', 'Foundation'

end