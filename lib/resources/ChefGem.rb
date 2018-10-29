class Inspec_Gen::ChefGem
  def self.chefgem(data, platform) # platform is unused but needed because other methods are using it. 
    Inspec_Gen::Package.package(data, platform)
  end
end #class
