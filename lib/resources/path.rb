class Inspec_Gen::Path
  def self.path(data, platform)

    if (data['action'][0].eql?('delete') || data['action'][0].eql?('remove'))
      action = 'should_not exist'
    else
      action = 'should exist'
    end

    if data['path'].nil?
      path = data['name']
    else
      path = data['path']
    end
    
    ::File.open(::Dir.pwd + "/test/smoke/default/#{platform}.rb", 'a') do |file|
      file.write(
"describe file('#{path}') do
  it { #{action} }
end\n\n")
      file.close
    end

  end
end #class
