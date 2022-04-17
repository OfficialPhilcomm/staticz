require_relative "../lib/manifest/manifest"

RSpec.describe "manifest" do
  context "generate manifest from define" do
    context "big manifest" do
      before do
        Staticz::Manifest.define do
          haml :haml_without_folder
          sass :sass_without_folder
          scss :scss_without_folder

          sub :foo do
            haml :haml_with_folder
            sass :sass_with_folder
            scss :scss_with_folder
          end
        end
      end

      it "generates correct manifest" do
        expect(Staticz::Manifest.instance.elements).to match(
          [
            have_attributes(name: :haml_without_folder),
            have_attributes(name: :sass_without_folder),
            have_attributes(name: :scss_without_folder),
            have_attributes(name: :foo, elements: match([
              have_attributes(name: "foo/haml_with_folder"),
              have_attributes(name: "foo/sass_with_folder"),
              have_attributes(name: "foo/scss_with_folder")
            ]))
          ]
        )
      end
    end

    context "small manifest" do
      before do
        Staticz::Manifest.define do
          haml :haml_without_folder

          sub :foo do
            haml :haml_with_folder
          end
        end
      end

      context "unnested haml" do
        it "has correct paths generated" do
          expect(Staticz::Manifest.instance.elements.first.path).to eq "src/haml_without_folder.haml"
          expect(Staticz::Manifest.instance.elements.first.build_path).to eq "build/haml_without_folder.html"
          expect(Staticz::Manifest.instance.elements.first.link_path).to eq "/haml_without_folder"
        end
      end

      context "nested haml" do
        let(:haml_object) {
          Staticz::Manifest
            .instance
            .elements[1]
            .elements
            .first
        }

        it "has correct paths generated" do
          expect(haml_object.path).to eq "src/foo/haml_with_folder.haml"
          expect(haml_object.build_path).to eq "build/foo/haml_with_folder.html"
          expect(haml_object.link_path).to eq "/foo/haml_with_folder"
        end
      end
    end
  end
end
