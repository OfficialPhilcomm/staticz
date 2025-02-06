require_relative "../../../lib/manifest/manifest"

RSpec.describe Staticz::Compilable::ScssC do
  context "generated from manifest" do
    context "on top level" do
      before do
        Staticz::Manifest.define do
          scss :styles
        end
      end

      it "generates an instance" do
        expect(Staticz::Manifest.instance.elements).to match(
          [
            have_attributes(name: :styles)
          ]
        )
      end

      it "generates the correct paths" do
        expect(Staticz::Manifest.instance.elements.first.source_path).to eq("src/styles.scss")
        expect(Staticz::Manifest.instance.elements.first.build_path).to eq("build/styles.css")
      end

      context "create link function" do
        before do
          Staticz::Manifest.instance.elements.first.create_link_function
        end

        it "generates correct path helper" do
          expect(styles_path).to eq("styles.css")
        end
      end
    end

    context "in subfolder" do
      before do
        Staticz::Manifest.define do
          sub :css do
            scss :styles
          end
        end
      end

      it "generates an instance" do
        expect(Staticz::Manifest.instance.elements).to match(
          [
            have_attributes(elements: match([
              have_attributes(name: "css/styles")
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
        ).to eq("src/css/styles.scss")
        expect(Staticz::Manifest
          .instance
          .elements.first
          .elements.first
          .build_path
        ).to eq("build/css/styles.css")
      end

      context "create link function" do
        before do
          Staticz::Manifest.instance.elements.first.elements.first.create_link_function
        end

        it "generates correct path helper" do
          expect(css_styles_path).to eq("css/styles.css")
        end
      end
    end
  end
end
