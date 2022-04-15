Statics::Manifest.define do
  haml :index

  sub :css do
    sass :main
  end
end
