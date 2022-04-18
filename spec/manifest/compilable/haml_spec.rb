require_relative "../../../lib/manifest/manifest"

RSpec.describe Staticz::Compilable::Haml do
  context "generated from manifest" do
    context "on top level" do
      before do
        Staticz::Manifest.define do
          haml :index
        end
      end

      it "generates an instance" do
        expect(Staticz::Manifest.instance.elements).to match(
          [
            have_attributes(name: :index)
          ]
        )
      end

      it "generates the correct paths" do
        expect(Staticz::Manifest.instance.elements.first.source_path).to eq("src/index.haml")
        expect(Staticz::Manifest.instance.elements.first.build_path).to eq("build/index.html")
      end

      context "create link function" do
        before do
          Staticz::Manifest.instance.elements.first.create_link_function
        end

        it "generates correct path helper" do
          expect(index_path).to eq("index.html")
        end
      end
    end

    context "in subfolder" do
      before do
        Staticz::Manifest.define do
          sub :test_folder do
            haml :index
          end
        end
      end

      it "generates an instance" do
        expect(Staticz::Manifest.instance.elements).to match(
          [
            have_attributes(elements: match([
              have_attributes(name: "test_folder/index")
            ]))
          ]
        )
      end

      it "generates the correct paths" do
        expect(Staticz::Manifest
          .instance
          .elements.first
          .elements.first
          .source_path
        ).to eq("src/test_folder/index.haml")
        expect(Staticz::Manifest
          .instance
          .elements.first
          .elements.first
          .build_path
        ).to eq("build/test_folder/index.html")
      end

      context "create link function" do
        before do
          Staticz::Manifest.instance.elements.first.elements.first.create_link_function
        end

        it "generates correct path helper" do
          expect(test_folder_index_path).to eq("test_folder/index.html")
        end
      end
    end
  end
end
