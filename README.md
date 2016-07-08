# Martian Components
![License](https://img.shields.io/github/license/mashape/apistatus.svg)
![Stage](https://img.shields.io/badge/Stage-Developing-red.svg)

## Description

An engine with components ready for the creation and development of websites, using ruby on rails.

1. [Installation](#installation)
2. [Starting](#starting)
3. [Integration](#integration)
4. [Building](#building)

## TODO
- Create google maps component.
- Create a rake to create this automatically 

## Installation

To download, you need to have the following requirements on your machine

- [Git](https://git-scm.com/)
- [Ruby on rails](http://rubyonrails.org/)

```bash
  git clone https://github.com/polomarte/martian_components
```

## Starting


## Integration

    # Gemfile
    gem 'martian_components', github: 'polomarte/martian_components', branch: 'master'

    # routes.rb
    get '/components/:name', to: 'components#show'

    # Generate a migration with the follow attributes:
      TODO: Create a rake to create this automatically

      string   "type"
      string   "key"
      string   "title"
      string   "h1"
      string   "h2"
      text     "text"
      text     "data"
      boolean  "affix_nav_navegable", default: false
      string   "file"
      integer  "parent_id"
      integer  "position"

## Building

- If you want to see the preview , you can use the following commands to access the folder and start the server

```bash
  cd martian_components/test/dummy && rails server
```

## License

Martian Components is released under the [MIT license](https://github.com/polomarte/martian_components/blob/master/MIT-LICENSE).
