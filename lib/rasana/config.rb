# encoding: utf-8
require 'yaml'

module Rasana
  class Config
    attr_accessor :config
    def initialize(options)
      _config = YAML.load(open("#{ENV['HOME']}/.rasana.yml").read)
      _config = _config.merge(verbose: true) if options["verbose"]
      @config = _config
    end

    def [](key)
      config[key]
    end

    def []=(key, val)
      config[key] = val
    end
  end
end
