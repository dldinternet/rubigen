require 'optparse'

module Rubigen
  class CLI
    attr_reader :stdout
    
    def self.execute(stdout, arguments=[])
      self.new.execute(stdout, arguments)
    end

    def execute(stdout, arguments=[])
      @stdout = stdout
      main_usage and return unless scope = arguments.shift

      require 'rubigen/scripts/generate'
      RubiGen::Base.use_component_sources!([scope.to_sym])
      RubiGen::Scripts::Generate.new.run(arguments, :stdout => stdout, :no_exit => true)
    end
    
    def main_usage
      stdout.puts <<-USAGE.gsub(/^        /, '')
      Usage: $0 scope generator [options for generator]
      USAGE
      true
    end
  end
end