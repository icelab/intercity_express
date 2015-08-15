require "spec_helper"

RSpec.describe IntercityExpress::TextHelpers do
  let(:helper) {
    Class.new(ActionView::Base) do
      include IntercityExpress::TextHelpers
    end.new
  }

  describe "#markdown" do
    let(:text) { "Here's Joe Cool" }
    subject(:formatted_text) { helper.markdown(text) }

    describe "Markdown input" do
      let(:text) { "Joe _Cool_" }

      it "renders markdown into HTML paragraphs" do
        is_expected.to eql "<p>Joe <em>Cool</em></p>"
      end
    end

    describe "HTML input" do
      let(:text) { "Joe Cool<script>something bad</script>" }

      it "sanitizes the text" do
        is_expected.to eql "<p>Joe Cool</p>"
      end
    end

    describe "punctuation" do
      let(:text) { "Here's Joe Cool" }

      it "converts punctuation into 'smart' punctuation" do
        is_expected.to eql "<p>Here’s Joe Cool</p>"
      end
    end

    it "returns text marked as HTML safe" do
      is_expected.to be_html_safe
    end
  end

  describe "#markdown_line" do
    let(:text) { "Here's Joe Cool" }
    subject(:formatted_text) { helper.markdown_line(text) }

    describe "Markdown input" do
      let(:text) { "Joe _Cool_" }

      it "renders markdown into HTML without paragraphs" do
        is_expected.to eql "Joe <em>Cool</em>"
      end

      context "headers" do
        let(:text) {
          <<-MARKDOWN.strip_heredoc
            # Snoopy is:
            Joe Cool
          MARKDOWN
        }

        it "renders headers inline" do
          is_expected.to eql "Snoopy is: Joe Cool"
        end
      end

      context "blockquotes" do
        let(:text) {
          <<-MARKDOWN.strip_heredoc
            Joe Quote:

            > I have a dream
          MARKDOWN
        }

        it "renders blockquotes inline" do
          is_expected.to eql "Joe Quote: I have a dream"
        end
      end

      context "horizontal rules" do
        let(:text) {
          <<-MARKDOWN.strip_heredoc
            Snoopy

            ***

            Charlie Brown
          MARKDOWN
        }

        it "replaces horizontal rules with a space" do
          is_expected.to eql "Snoopy Charlie Brown"
        end
      end

      context "lists" do
        let(:text) {
          <<-MARKDOWN.strip_heredoc
            Joe Shopper:

            * Eggs
            * Milk
          MARKDOWN
        }

        it "renders lists inline" do
          is_expected.to eql "Joe Shopper: Eggs Milk"
        end
      end

      context "line breaks" do
        let(:text) { "Snoopy is  \n" + "Joe Cool" }

        it "replaces line breaks with a space" do
          is_expected.to eql "Snoopy is Joe Cool"
        end
      end

      context "code blocks" do
        let(:text) {
          <<-MARKDOWN.strip_heredoc
            Joe Code:

                String.new
          MARKDOWN
        }

        it "renders code blocks inline" do
          is_expected.to eql "Joe Code: String.new"
        end
      end

      context "HTML blocks" do
        let(:text) {
          <<-MARKDOWN.strip_heredoc
            Joe HTML:

            <div>I am a programmer</div>
          MARKDOWN
        }

        it "strips block-level HTML" do
          is_expected.to eql "Joe HTML:"
        end
      end
    end

    describe "HTML input" do
      let(:text) { "Joe Cool <script>something bad</script>" }

      it "sanitizes the text" do
        is_expected.to eql "Joe Cool"
      end
    end

    describe "punctuation" do
      let(:text) { "Here's Joe Cool" }

      it "converts punctuation into 'smart' punctuation" do
        is_expected.to eql "Here’s Joe Cool"
      end
    end

    it "returns text marked as HTML safe" do
      is_expected.to be_html_safe
    end
  end

  describe "#smartypants_format" do
    let(:text) { "Here's Joe Cool" }
    subject(:formatted_text) { helper.smartypants_format(text) }

    describe "punctuation" do
      it "converts punctuation into 'smart' punctuation" do
        is_expected.to eql "Here’s Joe Cool"
      end
    end

    describe "HTML input" do
      let(:text) { "Joe Cool <script>something bad</script>" }

      it "sanitizes the text" do
        is_expected.to eql "Joe Cool"
      end
    end

    it "returns text marked as HTML safe" do
      is_expected.to be_html_safe
    end
  end

  describe "#widont_format" do
    subject(:formatted_text) { helper.widont_format(text) }

    context "text with ordinary length final words" do
      let(:text) { "It was a dark and stormy night." }

      it "replaces the last space with an HTML non-breaking space entity" do
        nbsp = "\u00A0"
        is_expected.to eql "It was a dark and stormy#{nbsp}night."
      end
    end

    context "text with very long final words" do
      let(:text) { "We are obviously separated by denominational differences." }

      it "doesn't change the last space" do
        is_expected.to eql text
      end
    end
  end
end
