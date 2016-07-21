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
