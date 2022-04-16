# Statics
Ruby tool allowing you to write a small website project in `haml`, `sass`, `scss` and `js`, and compile everything into static files before uploading them to a static server. This project takes a lot of inspiration from Ruby on Rails.

## Requirements
[Ruby 3.1.0 or newer](https://www.ruby-lang.org/) (not tested on older versions)

## Installation
`gem install statics`

## Usage
### Create new project
Create a new project by running
```
statics new [name]
```

### Develop website
To make development as easy as possible, you can run a dev server with
```
statics server
```
Whenever a file is saved, it will rebuild the files, so with a reload on the page you can immediately see what your changes did.

To print out the manifest, run `statics manifest`. It will also tell you the resource paths, more about that in [resource paths](#resource-paths)

#### Supported file types
- `haml` compiles to `html`
- `sass` compiles to `css`
- `scss` compiles to `css`
- `js` doesn't compile, just copies 1:1
- `coffee` compiles to `js`

#### Manifest
The manifest defines files that need to be built in order for the website to work. This does not include parts.

For example
```ruby
Statics::Manifest.define do
  haml :index

  sub :css do
    sass :main
  end

  sub :scripts do
    js :toggle_nav

    coffee :toggle_nav_but_coffee
  end
end
```
will build `src/index.haml`, `src/css/main.sass`, `src/scripts/toggle_nav.js` and `src/scripts/toggle_nav_but_coffee.coffee`. You can nest as many subdirectories as you want.

#### Helper methods
There are multiple helper methods to simplify your work.

#### Resource paths
Much like rails, every resource generates a path for you to use. For example `src/styles/main.sass` translates to `styles_main_path`.

##### Render
If you want to include the partial `src/nav.haml` in your `index.haml`, you can just use `= render "nav"`. You can also instead use a symbol.

Note: you don't have to parts that you render in the manifest to avoid creating seperate `html` files for them. Parts will just be rendered into the view they are called from.

##### Stylesheets
If you wanna include the stylesheet `src/styles/main.sass`, you can use `= stylesheet styles_main_path` to link it.

##### Links
Like with [stylesheets](#stylesheets), you can use generated routes to link to a resource. `= link index_path` will translate to `src/index.haml`.
If you want to have text on the link, use `= link index_path, text: "foo"`. You can also nest other haml into like:
```ruby
= link index_path do
  .bar
```

##### Javascripts
Javascript files work the same way. The helper `= javascript scripts_toggle_path` helps you to link files the same way as [links](#links) and [stylesheets](#stylesheets).

### Build
You can build the project with `statics build`. All files included in the manifest will be built and put into the `build` folder. In a CI workflow, you can then take the build files and push them to a static website server.
