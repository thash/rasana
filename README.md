# Rasana

Command-line interface for Asana API written in Ruby.


## Installation

    $ gem install rasana

## Usage

First, create `~/.rasana.yml` and fill your [Asana api_key](https://app.asana.com/-/account_api).

    $ cat ~/.rasana.yml
    api_key: xxxxxx.xxxxxxxxxxxxxxxxxxxx

Then you can access to Asana API. At first find out who am I.

    $ asana me
    id: 8808888888
    name: memerelics
    email: hoge@gmail.com
    workspaces:
      - 1111111111111: 'boring job'
      - 2222222222222: 'favorite_workspace'

Display tasks assigned to you.

    $ asana tasks
      * Identify resources to be monitored.
      * Define users and workflow
      * Identify event sources by resource type.
      * Define the relationship between resources and business systems.
      * Identify tasks and URLs by resource type.
      * Define the server configuration.

Also you can limit result by `--on` option.

    $ asana tasks --on favorite_workspace
      * Define the server configuration.

Others...

    $ asana projects
    1111111111111: ProjectX
    3333333333333: My Important Project

    $ asana tags
    1111111111111: tagA
    2222222222222: tagB


Show help.

    $ asana help
    $ asana help tasks


## TODO

* POST/PUT/DELETE.
* tasks on a project.
* tasks on a tag.
* GitHub integration.
* Make it faster.


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
