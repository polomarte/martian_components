# Martian Components

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


## TODO

* Sanitize uploaded SVG files. A SVG file can contain undesired tags like <style> or worse...
