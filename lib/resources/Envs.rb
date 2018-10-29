class Inspec_Gen::Env
  def self.env(data, platform)

    if data['key_name'].nil?
      key_name = data['name']
    else
      key_name = data['key_name']
    end

    if (data['action'][0].eql?('create') || data['action'][0].eql?('modify'))
      ::File.open(::Dir.pwd + "/test/smoke/default/#{platform}.rb", 'a') do |file|
        file.write(
"describe os_env('#{key_name}') do
  its('content') { should include '#{data["value"]}' }
end\n\n")
        file.close
      end
    end

  end
end #class
