require_relative "../../../lib/manifest/manifest"

RSpec.describe Staticz::Compilable::SimpleFile do
  context "generated from manifest" do
    context "on top level" do
      before do
        Staticz::Manifest.define do
          file "logo.png"
        end
      end

      it "generates an instance" do
        expect(Staticz::Manifest.instance.elements).to match(
          [
            have_attributes(name: "logo.png")
          ]
        )
      end

      it "generates the correct paths" do
        expect(Staticz::Manifest.instance.elements.first.source_path).to eq("src/logo.png")
        expect(Staticz::Manifest.instance.elements.first.build_path).to eq("build/logo.png")
      end
    end

    context "in subfolder" do
      before do
        Staticz::Manifest.define do
          sub :img do
            file "logo.png"
          end
        end
      end

      it "generates an instance" do
        expect(Staticz::Manifest.instance.elements).to match(
          [
            have_attributes(elements: match([
              have_attributes(name: "img/logo.png")
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
        ).to eq("src/img/logo.png")
        expect(Staticz::Manifest
          .instance
          .elements.first
          .elements.first
          .build_path
        ).to eq("build/img/logo.png")
      end
    end
  end
end
