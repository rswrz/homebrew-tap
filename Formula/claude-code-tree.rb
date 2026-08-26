class ClaudeCodeTree < Formula
  desc "Terminal UI for browsing Claude Code sessions as a fork tree"
  homepage "https://github.com/rswrz/claude-code-tree"
  url "https://github.com/rswrz/claude-code-tree/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "c547185fa150627a7e4041f900e7bf509f523666ffba6c20623dc5bab2acc6e5"
  license "MIT"
  head "https://github.com/rswrz/claude-code-tree.git", branch: "main"

  depends_on "python@3.13"

  # The package is pure standard library, so there is nothing to build or
  # resolve: put the sources on PYTHONPATH and run the module directly.
  def install
    libexec.install Dir["src/*"]
    (bin/"claude-code-tree").write <<~SH
      #!/bin/bash
      export PYTHONPATH="#{libexec}${PYTHONPATH:+:$PYTHONPATH}"
      exec "#{formula_opt_bin("python@3.13")}/python3.13" -m cct "$@"
    SH
    chmod 0755, bin/"claude-code-tree"
  end

  test do
    assert_match "claude-code-tree #{version}", shell_output("#{bin}/claude-code-tree --version")
  end
end
