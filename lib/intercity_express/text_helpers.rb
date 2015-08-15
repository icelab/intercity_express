require "intercity_express/text_helpers/html_without_block_elements_renderer"

module IntercityExpress
  # Public: Various helpful text formatting helpers.
  module TextHelpers
    include Funkify

    def markdown(text)
      (_markdown | _smartypants | _sanitize({}) | _html_safe).(text)
    end

    def markdown_line(text)
      (_markdown_line | _smartypants | _sanitize({}) | _html_safe).(text)
    end

    def smartypants_format(text, sanitize_options: {})
      (_smartypants | _sanitize(sanitize_options) | _html_safe).(text)
    end

    def widont_format(text, sanitize_options: {})
      (_widont | _sanitize(sanitize_options) | _html_safe).(text)
    end

    private

    auto_curry

    def _markdown(text)
      Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(text)
    end

    def _markdown_line(text)
      renderer = HTMLWithoutBlockElementsRenderer.new(filter_html: false)
      Redcarpet::Markdown.new(renderer, lax_spacing: true, no_intra_emphasis: true).render(text)
    end

    def _widont(text)
      # Only make the final space non-breaking if the final two words fit
      # within 20 characters.
      if text.length > 20 && text[-20..-1][/\s+\S+\s+\S+$/].nil?
        text
      else
        text.gsub(/\s+(?=\S+$)/, "&nbsp;")
      end
    end

    def _smartypants(text)
      Redcarpet::Render::SmartyPants.render(text)
    end

    def _sanitize(options, text)
      sanitize(text, options).strip
    end

    def _html_safe(text)
      text.html_safe
    end
  end
end
