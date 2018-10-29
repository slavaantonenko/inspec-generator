class Inspec_Gen::WindowsCookbookPackage
  def self.windowscookbookpackage(data, platform) # platform is unused but needed because other methods are using it. 
    Inspec_Gen::Package.package(data, platform)
  end
end #class
