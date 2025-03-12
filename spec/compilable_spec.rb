require_relative "../lib/manifest/compilable"

class TestCompilable
  include Staticz::Compilable

  attr_reader :name

  def initialize(name)
    @name = name
  end
end

RSpec.describe "compilable" do
  context "#path_method_name" do
    subject do
      TestCompilable.new(filename).path_method_name
    end

    context "with upper case letters" do
      let(:filename) { "Pen-and-Paper-logo-large.png" }

      it "lower cases letters" do
        expect(subject).to eq("pen_and_paper_logo_large_png_path")
      end
    end

    context "with spaces" do
      let(:filename) { "Pen and Paper logo large.png" }

      it "removes spaces" do
        expect(subject).to eq("pen_and_paper_logo_large_png_path")
      end

      context "with multiple space in a row" do
        let(:filename) { "Pen  Paper.png" }

        it "combines spaces into one underscore" do
          expect(subject).to eq("pen_paper_png_path")
        end
      end
    end
  end
end
