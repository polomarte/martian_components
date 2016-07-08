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
- Create a rake to create this automatically.

## Installation

To download, you need to have the following requirements on your machine.

- [Git](https://git-scm.com/)
- [Ruby on rails](http://rubyonrails.org/)

```bash
  git clone https://github.com/polomarte/martian_components
```

## Starting
  - You can test your applicantion using.   

```bash
  ~/martian_components/test/dummy$ rails server
```

  1 - Create a view: 

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
    
  2 -  Create a model:

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

  3 - Create the javascript and .sass files:

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
  4 - Create the element in seeds.rb file, and run.

~~~~~ ruby
  Test.create!(
  key: 'app:test:test_a',
  title: 'New Component',
  h1: 'New Component',
  h2: 'A Component o/')
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

## License

Martian Components is released under the [MIT license](https://github.com/polomarte/martian_components/blob/master/MIT-LICENSE).