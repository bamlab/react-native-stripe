
Pod::Spec.new do |s|
  s.name         = "RNStripe"
  s.version      = "0.0.1"
  s.summary      = "RNStripe"
  s.description  = <<-DESC
                  Stripe module for react-native
                   DESC
  s.homepage     = ""
  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  s.author             = { "author" => "nicolasd@bam.tech" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/author/RNStripe.git", :tag => "master" }
  s.source_files  = "RNStripe/**/*.{h,m}"
  s.requires_arc = true


  s.dependency "React"
  #s.dependency "others"

end

  
