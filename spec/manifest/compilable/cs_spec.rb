require_relative "../../../lib/manifest/manifest"

RSpec.describe Staticz::Compilable::Cs do
  context "generated from manifest" do
    context "on top level" do
      before do
        Staticz::Manifest.define do
          coffee :like
        end
      end

      it "generates an instance" do
        expect(Staticz::Manifest.instance.elements).to match(
          [
            have_attributes(name: :like)
          ]
        )
      end

      it "generates the correct paths" do
        expect(Staticz::Manifest.instance.elements.first.source_path).to eq("src/like.coffee")
        expect(Staticz::Manifest.instance.elements.first.build_path).to eq("build/like.js")
      end

      context "create link function" do
        before do
          Staticz::Manifest.instance.elements.first.create_link_function
        end

        it "generates correct path helper" do
          expect(like_path).to eq("like.js")
        end
      end
    end

    context "in subfolder" do
      before do
        Staticz::Manifest.define do
          sub :scripts do
            coffee :like
          end
        end
      end

      it "generates an instance" do
        expect(Staticz::Manifest.instance.elements).to match(
          [
            have_attributes(elements: match([
              have_attributes(name: "scripts/like")
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
        ).to eq("src/scripts/like.coffee")
        expect(Staticz::Manifest
          .instance
          .elements.first
          .elements.first
          .build_path
        ).to eq("build/scripts/like.js")
      end

      context "create link function" do
        before do
          Staticz::Manifest.instance.elements.first.elements.first.create_link_function
        end

        it "generates correct path helper" do
          expect(scripts_like_path).to eq("scripts/like.js")
        end
      end
    end
  end
end
