class Inspec_Gen::Package
  def self.package(data, platform) # platform is unused but needed because other methods are using it. 
    data['name'].split(', ').each do |name|
      ::File.open(::Dir.pwd + "/test/smoke/default/#{platform}.rb", 'a') do |file|
        file.write(
"describe package('#{name}') do
  it { should be_installed }  
end\n\n")
        file.close
      end
    end
  end
end #class
