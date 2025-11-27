# 1.1.6
- Added `render` support for slim

# 1.1.5
- Added slim support

# 1.1.4
- Fixed an issue where `index_missing?` was crashing if no index was available and sub was present

# 1.1.3
- Added flag `--with-gitignore` to `new` command
- Added new `clean` template
- Improved sass and scss compiling, combining them into one class
- Improved new user experience

# 1.1.2
- Fixed winsize error on some docker images

# 1.1.1
- Added custom error handler for `sass-embedded`
- Added `.gitignore` to templates
- Removed screen clearing, as it didn't work properly on big manifests

# 1.1.0
- Added `--version` to base command
- Replaced deprecated `sassc` with `sass-embedded` gem
- Improved template system, allowing for different variants of templates. The old default template is now `layout`, and newly introduced is `default`.
- Fixed placeholder for `name` parameter description on `new` subcommand
- Fixed multiple issues with path names not being generated correctly, for example spaces weren't converted to underscores

# 1.0.15
- Allow `sub` without content

# 1.0.14
- Fixed a regex bug happening with ruby > `3.1.1`

# 1.0.13
- Fixed CSSBundle crash when using build command

# 1.0.12
- Added port argument to `staticz server` command, use `staticz server --help` for more information
- Added environment argument to `staticz server|build` commands, use `staticz server|build --help` for more information
- Added environment helpers `development?` and `production?`
- Improved command system allowing for better printouts

# 1.0.11
- Added css and js bundles (consult `readme.md` for more info)

# 1.0.10
- Added `/` in front of all generated paths
- Added `shorten` option for generated paths (`index_path(shorten: true)`), which trims the file ending
- Added server trigger for rebuilding when `manifest.rb` is modified
- Added resource path generation for `file` types in manifest
- Fixed `staticz manifest` output showing errors because routes are not created

# 1.0.8
- Fixed `render` locals not working without giving it a block

# 1.0.7
- Added `development?` and `production?` helpers. `staticz server` will run the project in development mode, while `staticz build` runs it in production mode.
- Added locals functionality to `render` helper. For more info, see the helper section on the readme.

# 1.0.6
- Added ability to put custom code into `/lib` folder. All `.rb` files in this folder will be loaded automatically and reloaded when rebuilding the app.

# 1.0.5
- Improved manifest printout, now includes compiler errors
- Added page reload when rebuilding manifest (section added to readme)
- Make haml files accessible via path without `.html` ending (`/foo/bar.html` can be accessed as `/foo/bar`), as some webservers support this

# 1.0.4
- Added helper to insert inline svgs
- Added ability to include raw files in build

# 1.0.3
- Fixed missing babel transpiler dependency

# 1.0.2
- Added serving of `index.html` on `/`
- Added basic react functionality (readme contains more info)

# 1.0.1
- Added better gem description on rubygems.org

# 1.0.0
- Added initial version
