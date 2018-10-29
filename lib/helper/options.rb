class Inspec_Gen::Options
  def self.options
    # Commands
    if ARGV[0] == 'help'
      puts ::File.read(::File.dirname(::File.expand_path('../..', __FILE__)) + '/responses/inspec_gen_help.txt')
      exit
    end

    # Options
    flags = { "-d" => false, "-r" => "default", "-j" => "", "-g" => "", "-p" => "" }
    i = 0
    args_length = ARGV.length

    while i < args_length do
      current_arg = ARGV[i]
      next_arg = ARGV[i+1]

      if flags.key?(current_arg)
        if next_arg.match(/^-[a-z]/).nil?
          flags[current_arg] = next_arg
          i += 2
        elsif !next_arg.match(/^-[a-z]/).nil? && !flags[current_arg]
          flags[current_arg] = true
          i += 1
        else
          abort "Invalid value for #{current_arg} option."
        end
      else
        abort "Invalid option for #{current_arg}"
      end
    end

    return flags
  end
end