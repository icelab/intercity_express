module IntercityExpress
  module TextHelpers
    # Internal: Render any markdown text and ensure it returns only span-level
    # HTML elements.
    #
    # This is intended for use when Markdown styling would be useful for
    # something that must still appear on a single line (like a page title).
    class HTMLWithoutBlockElementsRenderer < Redcarpet::Render::HTML
      def initialize(options = {})
        super(options.merge(tables: false))
      end

      # Regular markdown, just ignore all the block-level elements

      def block_code(code, _language)
        " #{code} "
      end

      def block_quote(quote)
        " #{quote} "
      end

      def block_html(_raw_html)
        ""
      end

      def header(text, _header_level)
        " #{text} "
      end

      def hrule
        " "
      end

      def list(contents, _list_type)
        contents
      end

      def list_item(text, _list_type)
        " " + text.strip
      end

      def paragraph(text)
        text
      end

      # Span-level calls

      def linebreak
        " "
      end

      # Postprocessing: strip newlines

      def postprocess(document)
        document.tr("\n", " ").strip
      end
    end
  end
end
