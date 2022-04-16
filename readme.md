# Statics
Ruby tool allowing you to write a small website project in `haml`, `sass` and `scss`, and compile everything into static files before uploading them to a static server. This project takes a lot of inspiration from Ruby on Rails.

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

#### Manifest
The manifest defines files that need to be built in order for the website to work. This does not include parts.

For example
```ruby
Statics::Manifest.define do
  haml :index

  sub :css do
    sass :main
  end
end
```
will build `src/index.haml` and `src/css/main.sass`. You can nest as many subdirectories as you want.

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

### Build
You can build the project with `statics build`. All files included in the manifest will be built and put into the `build` folder. In a CI workflow, you can then take the build files and push them to a static website server.
