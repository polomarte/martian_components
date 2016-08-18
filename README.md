
# Martian Components
![License](https://img.shields.io/github/license/mashape/apistatus.svg)
![Stage](https://img.shields.io/badge/Stage-Developing-red.svg)

## Description

An engine with components ready for the creation and development of websites, using ruby on rails.

- [Installation](#installation)
- [Getting Started](#getting-started)
- [Create a Component](https://github.com/yagoazedias/martian_components/blob/master/doc/create_component.md)
- [Instantiating](https://github.com/yagoazedias/martian_components/blob/master/doc/components/banner.md)
  - [Banner](https://github.com/yagoazedias/martian_components/blob/master/doc/components/banner.md)
  - [Know More Links](https://github.com/yagoazedias/martian_components/blob/master/doc/components/know_more_links.md)
  - [Know More Link](https://github.com/yagoazedias/martian_components/blob/master/doc/components/know_more_links.md##know-more-link)
  - [Hover Group](https://github.com/yagoazedias/martian_components/blob/master/doc/components/hover_group.md)
  - [Hover Item](https://github.com/yagoazedias/martian_components/blob/master/doc/components/hover_group.md#hover-item)
- [Integration](#integration)
- [Building](#building)
- [Administrator](#administrator)

## Installation

To download, you need to have the following requirements on your machine.

- [Git](https://git-scm.com/)
- [Ruby on rails](http://rubyonrails.org/)

```bash
  git clone https://github.com/polomarte/martian_components
```

## Getting Started
  - You can test your applicantion using.

```bash
  ~/martian_components/test/dummy$ rails server
```

```bash
  rake db:seed
```

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

- If you want to see the preview , you can use the following commands to access the folder and start the server.

```bash
  cd martian_components/test/dummy && rails server
```

## Administrator

- You or your client can use the [activeadmin](http://activeadmin.info/) to manager your website, editing the components with a dynamic form:
~~~~ruby
  AdminUser.create(email: 'example@domain.co', password: '123')
  # url: localhost:3000/admin
~~~~

## License

Martian Components is released under the [MIT license](https://github.com/polomarte/martian_components/blob/master/MIT-LICENSE).
