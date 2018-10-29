class Inspec_Gen::Platforms
  def self.get()
    if !::File.exist?('metadata.rb')
      raise 'Could not find metadata.rb which is vital for tests creation process'
    end

    content = ::File.read("#{::Dir.pwd}/metadata.rb")
    platforms_from_metadata = Array.new
    
    if content.lines.grep(/^\%w/).any?

      found_arr = false
      content_arr = content.lines
      for i in (0...content_arr.length)
        
        if found_arr
          if content_arr[i].include?('supports')
            break
          elsif content_arr[i].split("\n").first.eql?('end')
            found_arr = false
            platforms_from_metadata = []
          elsif content_arr[i].include?('depends')
            found_arr = false
          end
        end

        if content_arr[i].start_with?('%w')
          if content_arr[i].include?(').each do')
            platforms_from_metadata = (content_arr[i].split('%w')).last.split(').each').first.split('(').last.split(' ')
          elsif content_arr[i].include?('].each do')
            platforms_from_metadata = (content_arr[i].split('%w')).last.split('].each').first.split('[').last.split(' ')
          elsif content_arr[i].include?('}.each do')
            platforms_from_metadata = (content_arr[i].split('%w')).last.split('}.each').first.split('{').last.split(' ')
          else
            while (!content_arr[i+1].include?(').each do') && !content_arr[i+1].include?('].each do') && !content_arr[i+1].include?('}.each do'))
              i+=1
              platforms_from_metadata.push(content_arr[i].split(' ')[0])
            end
          end

          found_arr = true
        end

      end

    end

    if content.lines.grep(/^supports/).any?
      platforms_from_metadata += content.lines.grep(/^supports/)
    end
    
    platforms = Array.new
    temp_excludes=Array.new
    excludes = ::File.read(::File.dirname(::File.expand_path('../..', __FILE__)) + '/excludes')
    excludes = excludes.lines
    excludes.each do |ex|
      temp_excludes.push(ex.split("\n")[0])
    end
    
    platforms_from_metadata.each do |os|

      if os.start_with?('supports')
        os_plat = os.split("'")[1]
      else
        os_plat = os
      end

      if !temp_excludes.include?(os_plat)
        platforms.push(os_plat)
      end
    end

    return platforms
  end

  def self.getLatestFromFauxhai()
    platforms = { "aix"        => "7.1",
                  "amazon"     => "2017.03",
                  "arch"       => "4.10.13-1-ARCH",
                  "centos"     => "7.4.1708",
                  "chefspec"   => "0.6.1",
                  "clearos"    => "7.0",
                  "debian"     => "9.1",
                  "dragonfly4" => "4.8-RELEASE",
                  "fedora"     => "26",
                  "freebsd"    => "11.1",
                  "gentoo"     => "4.9.6-gentoo-r1",
                  "ios_xr"     => "6.0.014I",
                  "linuxmint"  => "18.1",
                  "nexus"      => "5",
                  "omnios"     => "151018",
                  "opensuse"   => "42.3",
                  "oracle"     => "7.4",
                  "raspbian"   => "8.0",
                  "redhat"     => "7.4",
                  "smartos"    => "5.11",
                  "solaris2"   => "5.11",
                  "suse"       => "12.3",
                  "ubuntu"     => "16.04",
                  "windows"    => "2016" }

    return platforms
  end
end #class
