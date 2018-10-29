class Inspec_Gen
  def self.Gen
    # Load ruby modules.
    require 'chef/client'
    require 'chef/mash'
    require 'chef/providers'
    require 'chef/resources'
    require 'fauxhai'
    require 'fileutils'
    require 'json'
    require 'net/http'
    require 'open-uri'
    require 'rbconfig'
    require 'securerandom'
    require 'uri'
    require 'zip'   
    # load custom version of chefspec
    $LOAD_PATH.unshift "#{::File.dirname(::File.dirname(__FILE__))}/gems/chefspec/lib"
    require 'chefspec'
    
    Gem.loaded_specs.values.inject([]){'chefspec'}
    Gem.loaded_specs['chefspec'] = Gem::Specification.new
    Gem.loaded_specs['chefspec'].version=Gem::Version.new(ChefSpec::VERSION) 
    
    # Libraries requirement
    Dir[::File.dirname(__FILE__) + '/helper/*.rb'].each {|file| require "helper/#{::File.basename(file, '.rb')}" }
    libs = Dir[::File.dirname(__FILE__) + '/resources/*.rb'].each {|file| require "resources/#{::File.basename(file, '.rb')}" }

    # Flags.
    flags = Options.options
    debug = flags['-d']
    recipe = flags['-r'].to_s
    json_attributes_path = flags['-j'].to_s
    json_attributes_platform = flags['-g'].to_s
    single_platform=flags['-p'].to_s
    cookbook_name = ::File.read("#{Dir.pwd}/metadata.rb").lines.grep(/^name/)[0].split("'")[1]

    if cookbook_name.nil?
      cookbook_name = ::File.read("#{Dir.pwd}/metadata.rb").lines.grep(/^name/)[0].split('"')[1]
    end

    # Prerequistes Check. If Cheffile and inspec configuration files are exist.
    if !::File.exist?('Berksfile')
      abort 'Could not find Berksfile which is vital for tests creation process'
    elsif !::File.exist?("recipes/#{recipe}.rb")
      abort "Could not find #{recipe}.rb"
    end

    # Define Temp directory.
    if RbConfig::CONFIG['host_os'].match(/mswin|msys|mingw|cygwin|bccwin|wince|emc/i)
      temp_folder = 'C:/Windows/Temp/inspec-gen'
    else
      temp_folder = '/tmp/inspec-gen'
    end
    ::Dir.mkdir(temp_folder) unless ::File.exists?(temp_folder)
    
    puts 'Start berks'

    RSpec.configuration.cookbook_path = "#{temp_folder}/cookbooks"
    `berks vendor --delete #{RSpec.configuration.cookbook_path}`   

    puts 'berks completed'

    # Get OS platforms from metadata.
    if single_platform.empty?
      platforms = Platforms.get()
    else
      platforms = [single_platform]
    end
    fauxhai_platforms = Platforms.getLatestFromFauxhai()

    resources_collection = Hash.new

    puts 'Start converge'
    
    # Run fauxhai on each platform.
    platforms.each do |platform|
      @solo_runner = ChefSpec::SoloRunner.new(platform: platform, version: fauxhai_platforms[platform])

      if !json_attributes_path.empty? && (json_attributes_platform.empty? || json_attributes_platform.eql?(platform))
          @solo_runner.node.normal.update(JSON.parse(::File.read(json_attributes_path)))
      end
      
      @solo_runner.converge("#{cookbook_name}::#{recipe}")
      @output=@solo_runner.run_context.resource_collection.entries
      @json_output = JSON.pretty_generate(@output)
      resources_collection[platform] = JSON.parse(@json_output)
    end

    puts 'Converge completed'

    puts 'Start tests Generation'

    TestGenerator.testsGenerator(resources_collection, libs, debug)
    
    puts 'Generation completed, the tests are ready'
  end
end
