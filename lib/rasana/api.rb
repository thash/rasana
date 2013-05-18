require 'rubygems'
require 'bundler/setup'
require 'faraday'
require 'faraday_middleware'
require 'hashie/mash'
require 'base64'

require 'rasana/config'

module Rasana
  class Api
    attr_reader   :config
    attr_accessor :workspace, :project, :tag, :me

    def initialize(options)
         @config = Config.new(options)
      @workspace = find_workspace(@config['workspace'])
        @project = find_project(@config['project'])
            @tag = find_tag(@config['tag'])
    end

    def api_key
      config['api_key']
    end

    def me
      @me ||= get '/users/me'
    end

    def workspaces
      get '/workspaces'
    end

    def projects
      get '/projects'
    end

    def tags
      get '/tags'
    end

    def tasks
      if workspace
        vputs "fetching tasks from... #{workspace.name}"
        get "/tasks?workspace=#{workspace.id}&assignee=#{me.data.id}"
      elsif project # TODO
      elsif tag # TODO
      else
        all_tasks
      end
    end

    def on(workspace_id_or_name)
      self.workspace = find_workspace(workspace_id_or_name)
      self
    end

    # #<Hashie::Mash errors=[#<Hashie::Mash
    #  message="Must specify exactly one of project, tag, or workspace">]>
    def all_tasks
      vputs "fetching all tasks..."
      workspaces.data.map do |w|
        on(w.id).tasks.data
      end.flatten
    end

    private
    def vputs(str)
      return unless config[:verbose]
      puts str
    end

    def find_workspace(id_or_name)
      find_resource(id_or_name, workspaces)
    end

    def find_project(id_or_name)
      find_resource(id_or_name, projects)
    end

    def find_tag(id_or_name)
      find_resource(id_or_name, tags)
    end

    def find_resource(id_or_name, resources)
      case id_or_name
      when Integer
        resources.data.find { |w| w.id == id_or_name }
      when String
        resources.data.find { |w| w.name =~ /#{id_or_name}/ }
      end
    end

    # Basic api comonents
    def connection
      options = {
        url: 'https://app.asana.com/',
        ssl: { verify: false }
      }
      @connection ||= Faraday.new(options) do |faraday|
        faraday.adapter Faraday.default_adapter # required
        faraday.request :json
        faraday.use FaradayMiddleware::Mashify
        faraday.use FaradayMiddleware::ParseJson
      end
    end

    def request(_method, _path, params = {})
      connection.headers[:authorization] =
        'Basic ' + ::Base64.encode64(api_key + ':').chomp
      path = '/api/1.0' + _path
      response = connection.send(_method) do |req|
        case _method
        when :get
          req.url path, params
        end
      end
      response.body
    end

    def get(path, params = {})
      request :get, path, params
    end

    def post(path, params = {})
      request :post, path, params
    end
  end
end
