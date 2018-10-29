action = ARGV[0]
gem_installation_file = 'inspec-gen-2.0.0.gem'
gem_spec_file = 'inspec-gen.gemspec'

if action.eql?('install')
  system("gem build #{gem_spec_file}")
  system("gem install #{gem_installation_file}")
elsif action.eql?('reinstall') || action.eql?('uninstall')
  system("gem uninstall -x inspec-gen")
  File.delete(gem_installation_file) if File.exist?(gem_installation_file)

  if action.eql?('reinstall')
    system("gem build #{gem_spec_file}")
    system("gem install #{gem_installation_file}")
  end
else
  puts 'Invalid argument!'
end
