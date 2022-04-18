# Staticz
Ruby tool allowing you to write a small website project in `haml`, `sass`, `scss` and `js`, and compile everything into static files before uploading them to a static server. This project takes a lot of inspiration from Ruby on Rails.

## Requirements
[Ruby 3.1.0 or newer](https://www.ruby-lang.org/) (not tested on older versions)

## Installation
`gem install staticz`

## Usage
### Create new project
Create a new project by running
```
staticz new [name]
```

### Develop website
To make development as easy as possible, you can run a dev server with
```
staticz server
```
Whenever a file is saved, it will rebuild the files, so with a reload on the page you can immediately see what your changes did.

To print out the manifest, run `staticz manifest`. It will also tell you the resource paths, more about that in [resource paths](#resource-paths)

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
Staticz::Manifest.define do
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

##### Resource paths
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

##### Inline svg
If you wanna print an inline svg, just use `= inline_svg("full_path")`. Full path is for example `img/test.svg`.

#### Experimental: React
A new experimental feature is React. It is a very basic implementation that does only support very basic components.
The current restrictions are:
1. Only `function` components are supported
2. Behaviors like `useState` need to be prefixed with `React.`, for example `React.useState()`.
3. `import` statements are not supported. If you wanna use special libraries like `axios` for web requests, it will be more complicated.
4. Two statements are needed in your `html` file to make a component work. Helpers exist for this

Example:
`manifest.rb`
```ruby
Staticz::Manifest.define do
  haml :index

  sub :components do
    react :search
  end
end
```

`src/components/like_button.js`
```jsx
function LikeButton(props) {
  const [liked, setLiked] = React.useState(false);

  return (
    <React.Fragment>
      {liked ? (
        <div>You liked</div>
      ) : (
        <button
          onClick={() => setLiked(true)}
        >Likey no</button>
      )}
    </React.Fragment>
  );
}
```

`src/index.haml`
```haml
%html
  %head
    -# Include rails js files and generate script src tags for your components (you can pass multiple paths)
    = react search_path

  %body
    -# Generate tag into which the component is mounted, first is the js name, second is the css class (optional)
    = react_component "LikeButton", "like-button"

    -# Mount components (you can pass multiple component names)
    = react_mount "LikeButton"
```

#### Other files
If you want to include a raw file in your build, add `file "path/to/file"` to your manifest. Example:
```ruby
Staticz::Manifest.define do
  sub :img do
    file "logo.png"
  end
end
```

Note: This will not create a path for now

### Build
You can build the project with `staticz build`. All files included in the manifest will be built and put into the `build` folder. In a CI workflow, you can then take the build files and push them to a static website server.
