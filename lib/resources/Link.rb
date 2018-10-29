class Inspec_Gen::Link
  def self.link(data, platform) # platform is unused but needed because other methods are using it.
    
    if (data['action'][0].eql? 'delete')
      action = 'should_not exist'
    else
      action = 'should exist'
    end

    if (data['action'][0].eql? 'delete')
      name = data['name']
    else
      name = data['to']
    end

    ::File.open(::Dir.pwd + "/test/smoke/default/#{platform}.rb", 'a') do |file|
      file.write(
"describe file('#{name}') do
  it { #{action} }
end\n\n")
      file.close
    end
  end
end #class
