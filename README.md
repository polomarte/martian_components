# Martian Components
![License](https://img.shields.io/github/license/mashape/apistatus.svg)
![Stage](https://img.shields.io/badge/Stage-Developing-red.svg)

## Description

An engine with components ready for the creation and development of websites, using ruby on rails.

1. [Installation](#installation)
2. [Getting Started](#getting-started)
3. [Create Component](#create-new-component)
4. [Instantiating a Banner](#instantiating-some-components)
5. [Integration](#integration)
6. [Building](#building)
7. [Administrator](#administrator)

## TODO
- Create google maps component.
- Create a rake to create this automatically.

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
## Create New Component

  - Create a view: 

    - Create a _form.slim file, a folder and a _test.slim file with the same name of your component in /martian_components/app/views


    ```bash
      .
      └── app
          └── view
              └── components
                  └── test
                      ├── _form.slim
                      └── _test.slim

    ````
    
    - The _form.slim file will be utilized in admin mode.
    
  - Create a model:

    - Create a .rb file in /martian_components/app/models folder
    
    ```bash
    .
    └── app
        └── models
            └── test.rb
    ```
    
    - In the .rb file you can write:

    ~~~~~ ruby
        class Test < Component
        end
    ~~~~~

  - Create the javascript and .sass files:

```bash    
  .
  └── app
      └── assets
          ├── javascript
          │   └── martian_components
          │       └── test.coffee
          └── stylesheets
              └── martian_components
                  └── components
                      └── test.sass

```

  - Write the sentences in your .coffeescript file.

```coffeescript
class @MC.Test extends @MC.Base
  @autoInit: ->
    $('.component-test').each (i, el) => new @($(el))

  constructor: (@el) ->
    super
```
- Create the element in seeds.rb file, and run.

~~~~~ ruby
  Test.create!(
  key: 'app:test:test_a',
  title: 'New Component',
  h1: 'New Component',
  h2: 'A Component o/')
~~~~~

```bash
  rake db:seed
```
## Instantiating some components
  
### Banner
  ~~~~~ ruby
  Banner.create!(
  key: 'app:banner:your_banner_key',
  title: 'your_title',
  h1: 'your_h1',
  h2: 'your_h2',
  images: [
    build_image('icon', 'you_icon.png'),
    build_image('background', 'your_background.jpg')],
  options: {data: {full_height_header: true}})
  ~~~~~
  
### Know More Links
  ~~~~~ ruby
    KnowMoreLinks.create!(
    key: 'app:know_more_links:your_know_more_links_key',
    title: 'your_title',
    h1: 'your_h1',
    h2: 'your_h2',
    items: links, # this links will be your know_more_links list
    images: [build_image('image', 'icon.png')])
~~~~~
  
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

- You or your client can use the activeadmin to manager your website, editing the components with a dynamic form:
~~~~ruby
  AdminUser.create(email: 'example@domain.co', password: '123')
  # url: localhost:3000/admin
~~~~

## License

Martian Components is released under the [MIT license](https://github.com/polomarte/martian_components/blob/master/MIT-LICENSE).
