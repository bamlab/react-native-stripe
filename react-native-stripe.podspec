require 'json'

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name           = package['name']
  s.version        = package['version']
  s.summary        = package['description']
  s.description    = package['description']
  s.license        = package['license']
  s.author         = package['author']
  s.homepage       = package['homepage']
  s.source         = { :git => "https://github.com/midrive/react-native-stripe.git", :tag => "master" }

  s.requires_arc = true
  s.platform     = :ios, "8.0"

  s.source_files = "ios/**/*.{h,m}"

  s.preserve_paths = 'README.md', 'package.json'

  s.dependency "React"
  s.dependency "Stripe"
end

