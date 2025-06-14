Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  spec.name         = "OIKit"
  spec.version      = "1.9.43"
  spec.summary      = "OIKit (UI For UIKit)"
  spec.description  = "Easy coding with OIKit"

  spec.homepage     = "https://github.com/OfficialKeen/OIKit"
  spec.license      = "MIT"
  spec.author       = { "Keen" => "zhekeen90@gmail.com" }
  spec.ios.deployment_target = '12.0'
  spec.source       = { :git => "https://github.com/OfficialKeen/OIKit.git", :tag => spec.version.to_s }
  spec.source_files  = "OIKit/**/*.{swift}"
  spec.swift_versions = "5.0"
  
  # spec.platform     = :ios, "12.0"
  # spec.resource  = "icon.png"
  # spec.resources = "Resources/*.png"
  # spec.preserve_paths = "FilesToSave", "MoreFilesToSave"
  # spec.library   = "iconv"
  # spec.libraries = "iconv", "xml2"
end
