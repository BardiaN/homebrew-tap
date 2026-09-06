# Homebrew formula for kronk-cli.
#
# url, sha256 and version are rewritten automatically by the release workflow
# in BardiaN/kronk-cli on every tag. Edit those by hand only to bootstrap.
class KronkCli < Formula
  desc "Terminal agent for local models served by Kronk"
  homepage "https://github.com/BardiaN/kronk-cli"
  url "https://github.com/BardiaN/kronk-cli/archive/refs/tags/v0.5.0.tar.gz"
  sha256 "cc52ce14a2dc43abeb894853ae9180565558558fa93812198b57a72d2448af63"
  license "Apache-2.0"

  depends_on "node"

  def install
    # No runtime dependencies, so the sources are the whole program.
    libexec.install Dir["*"]
    (bin/"kronk-cli").write <<~SH
      #!/bin/bash
      exec "#{formula_opt_bin("node")}/node" "#{libexec}/src/index.js" "$@"
    SH
    chmod 0755, bin/"kronk-cli"
  end

  test do
    assert_match "kronk-cli", shell_output("#{bin}/kronk-cli --help")
  end
end
