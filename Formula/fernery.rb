class Fernery < Formula
  desc "CLI tool for generating images of ferns 🌿 and other Iterated Function Systems"
  homepage "https://github.com/two-twelve/fernery"
  url "https://github.com/two-twelve/fernery/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "f8beffda2888eaa2645efbea2753cb388310ac2f72885c6db00c7dd33fc72a08"
  license "MIT"

  bottle do
    root_url "https://github.com/two-twelve/homebrew-tap/releases/download/fernery-0.1.0"
    sha256 cellar: :any_skip_relocation, monterey:     "16dbdec02689b3b4cbefacfc04ea3b805af1a283a8bbffaaf0b08a617024bdda"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ef4b5d1f3535bce5c9891f7dfaf52b63bf0ae38e0569b9b18bb243a63aba3f81"
  end

  # GHC shouldn't be needed on test (https://github.com/orgs/Homebrew/discussions/4284)
  depends_on "ghc@9.2" => [:build, :test]
  depends_on "haskell-stack" => [:build, :test]

  uses_from_macos "zlib"

  def install
    stack_args = [
      "--copy-bins",
      "--local-bin-path=#{bin}",
      "--system-ghc",
    ]

    system "stack", "build", *stack_args
    mv "#{bin}/fernery-exe", "#{bin}/fernery"
  end

  test do
    system "#{bin}/fernery", "-f", "barnsley"
    assert_predicate testpath/"fern.png", :exist?
  end
end
