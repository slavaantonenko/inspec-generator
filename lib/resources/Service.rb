class Inspec_Gen::Service
  def self.service(data, platform)

    service_state = 'should_not'
    service_status = 'should_not'

    data['action'].each do |action|
      if action.eql?('enable')
        service_status = 'should'
      end

      if action.eql?('start')
        service_state = 'should'
      end
    end
    
    if data['service_name'].nil?
      service_name = data['name']
    else
      service_name = data['service_name']
    end

    ::File.open(::Dir.pwd + "/test/smoke/default/#{platform}.rb", 'a') do |file|
      file.write(
"describe service('#{service_name}') do
  it { should be_installed }
  it { #{service_state} be_enabled }
  it { #{service_status} be_running }
end\n\n")
      file.close
    end

  end
end #class
