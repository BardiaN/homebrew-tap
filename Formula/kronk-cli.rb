# Homebrew formula for kronk-cli.
#
# url, sha256 and version are rewritten automatically by the release workflow
# in BardiaN/kronk-cli on every tag. Edit those by hand only to bootstrap.
class KronkCli < Formula
  desc "Terminal agent for local models served by Kronk"
  homepage "https://github.com/BardiaN/kronk-cli"
  url "https://github.com/BardiaN/kronk-cli/archive/refs/tags/v0.5.1.tar.gz"
  sha256 "baf5e076bf9ddb20c1f1e58e96a4713b903a01ae8a9590964a638e5d0542d9e7"
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
