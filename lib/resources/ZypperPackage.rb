class Inspec_Gen::ZypperPackage
  def self.zypperpackage(data, platform) # platform is unused but needed because other methods are using it.
    Inspec_Gen::Package.package(data, platform)
  end
end #class
