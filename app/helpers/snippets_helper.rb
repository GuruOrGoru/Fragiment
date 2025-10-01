module SnippetsHelper
  def format_code(code, language)
    formatter = Rouge::Formatters::HTML.new
    lexer = Rouge::Lexer.find(language.downcase) || Rouge::Lexers::PlainText
    formatter.format(lexer.lex(code)).html_safe
  end

  def monaco_language(language)
    # Map Rails language names to Monaco Editor language identifiers
    mapping = {
      "c++" => "cpp",
      "c#" => "csharp",
      "objective-c" => "objective-c",
      "html" => "html",
      "css" => "css",
      "javascript" => "javascript",
      "typescript" => "typescript",
      "python" => "python",
      "java" => "java",
      "ruby" => "ruby",
      "php" => "php",
      "go" => "go",
      "rust" => "rust",
      "sql" => "sql",
      "shell" => "shell",
      "bash" => "shell",
      "powershell" => "powershell",
      "yaml" => "yaml",
      "json" => "json",
      "xml" => "xml",
      "markdown" => "markdown",
      "dockerfile" => "dockerfile"
    }

    mapping[language.downcase] || "plaintext"
  end

  def ace_mode(language)
    # Map Rails language names to Ace Editor mode identifiers
    mapping = {
      "c++" => "c_cpp",
      "c#" => "csharp",
      "objective-c" => "objective_c",
      "html" => "html",
      "css" => "css",
      "javascript" => "javascript",
      "typescript" => "typescript",
      "python" => "python",
      "java" => "java",
      "ruby" => "ruby",
      "php" => "php",
      "go" => "golang",
      "rust" => "rust",
      "sql" => "sql",
      "shell" => "sh",
      "bash" => "sh",
      "powershell" => "powershell",
      "yaml" => "yaml",
      "json" => "json",
      "xml" => "xml",
      "markdown" => "markdown",
      "dockerfile" => "dockerfile"
    }

    "ace/mode/#{mapping[language.downcase] || 'text'}"
  end
end
