class Inspec_Gen::TestGenerator
  def self.testsGenerator(resources_collection, libs, debug)
    
    resources_collection.keys.each do |platform|
      if !::File.exist?('test/smoke/default/')
        ::FileUtils::mkdir_p 'test/smoke/default/'
      end

      if debug
        puts ''
        puts "#{platform}"
      end

      # Call suitable definition to generate a test.
      resources_collection[platform].each do |resource|
        if !resource['json_class'].nil?
          provider = resource['json_class'].split('::').last
          
          if debug
            puts provider
          end

          Inspec_Gen.constants.each do |lib|
            if lib.eql?(:"#{provider}")
              eval "Inspec_Gen::#{provider}.#{provider.downcase}(#{resource['instance_vars']}, '#{platform}')"
            end
          end
        end
      end

      if debug
        puts ''
      end
    end
  end
end #class