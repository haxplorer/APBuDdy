spec = Gem::Specification.new

#spec.date = File.utime('VERSION')
spec.name = 'apbd'
spec.platform = Gem::Platform::CURRENT
spec.require_path = '.'
spec.summary = 'Utility to Generate control files'
spec.version = '0.1'
spec.bindir = 'bin'
spec.executables = ['apbuddy', 'generate_control_files.rb']
spec.add_dependency('libxml-ruby', '>= 0.3.8')
spec.description = <<-EOF
APBuDdy is named after Abstract Package Build Description(APBD). 
The tool helps build packages from source tarballs in a semi-automated fashion
EOF
spec.email = 'rajagopal.developer@gmail.com'
spec.files = Dir['*'] + Dir['*']
spec.files << Dir['[A-Z]*'] + Dir['*']
#spec.hompage = 'http://en.opensuse.org/Abstract_Package_Build_Description'
spec.required_ruby_version = '>= 1.8.4'
spec.summary = 'A Generalized Packaging Tool'

