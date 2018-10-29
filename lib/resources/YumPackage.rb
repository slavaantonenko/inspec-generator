class Inspec_Gen::YumPackage
  def self.yumpackage(data, platform) # platform is unused but needed because other methods are using it.
    Inspec_Gen::Package.package(data, platform)
  end
end #class
