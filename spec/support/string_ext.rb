class String # :nodoc:
  def strip_heredoc
    whitespace = scan(/^[ \t]*(?=\S)/).min
    indent = whitespace.respond_to?(:size) ? whitespace.size : 0
    gsub(/^[ \t]{#{indent}}/, "")
  end
end
