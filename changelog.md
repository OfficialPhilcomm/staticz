# 1.0.7
Added `development?` and `production?` helpers. `staticz server` will run the project in development mode, while `staticz build` runs it in production mode.
Added locals functionality to `render` helper. For more info, see the helper section on the readme.

# 1.0.6
Added ability to put custom code into `/lib` folder. All `.rb` files in this folder will be loaded automatically and reloaded when rebuilding the app.

# 1.0.5
Improved manifest printout, now includes compiler errors
Added page reload when rebuilding manifest (section added to readme)
Make haml files accessible via path without `.html` ending (`/foo/bar.html` can be accessed as `/foo/bar`), as some webservers support this

# 1.0.4
Added helper to insert inline svgs
Added ability to include raw files in build

# 1.0.3
Fixed missing babel transpiler dependency

# 1.0.2
Added serving of `index.html` on `/`
Added basic react functionality (readme contains more info)

# 1.0.1
Added better gem description on rubygems.org

# 1.0.0
Added initial version
