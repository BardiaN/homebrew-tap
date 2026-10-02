# Homebrew formula for kronk-cli.
#
# url, sha256 and version are rewritten automatically by the release workflow
# in BardiaN/kronk-cli on every tag. Edit those by hand only to bootstrap.
class KronkCli < Formula
  desc "Terminal agent for local models served by Kronk"
  homepage "https://github.com/BardiaN/kronk-cli"
  url "https://github.com/BardiaN/kronk-cli/archive/refs/tags/v0.8.2.tar.gz"
  sha256 "dc50b5bd51f99ef55df045ce575a74fbb4899d4a2f4f3aa4a866b8cd5f5d548f"
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
