class Inspec_Gen::WindowsPackage
  def self.windowspackage(data, platform) # platform is unused but needed because other methods are using it. 
    Inspec_Gen::Package.package(data, platform)
  end
end #class
