class Inspec_Gen::WindowsService
  def self.windowsservice(data, platform)
    Inspec_Gen::Service.service(data, platform)
  end
end #class
