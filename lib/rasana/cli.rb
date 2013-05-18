require 'thor'
require 'rasana/api'

module Rasana
  class CLI < Thor
    attr_reader :api

    map '-T' => :tasks

    method_option :verbose, type: :boolean, aliases: '-v'
    def initialize(*args)
      super
      @api = Api.new(options)
    end

    desc 'me', 'show your information'
    def me
      api.me.data.map do |k, v|
        if k == 'workspaces'
          puts "#{k}:"
          v.map { |w| puts "  - #{w.id}: '#{w.name}'" }
        else
          puts "#{k}: #{v}"
        end
      end
    end

    desc 'workspaces', 'all workspaces'
    def workspaces
      api.workspaces.data.map do |w|
        puts "#{w.id}: #{w.name}"
      end
    end

    desc 'projects', 'all projects'
    def projects
      api.projects.data.map do |w|
        puts "#{w.id}: #{w.name}"
      end
    end

    desc 'tags', 'all tags'
    def tags
      api.tags.data.map do |w|
        puts "#{w.id}: #{w.name}"
      end
    end

    desc 'tasks [--on workspace]', 'non-archived tasks'
    option :on, banner: 'workspace', desc: 'tasks on specific workspace.'
    long_desc <<-EOT
    `asana tasks` will print out all non-archived tasks on all workspaces.
    EOT
    def tasks
      data = options[:on] ? api.on(options[:on]).tasks.data : api.all_tasks
      data.map do |t|
        puts "  *  #{t.name}"
      end
    end
  end
end
