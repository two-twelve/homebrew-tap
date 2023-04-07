class Fernery < Formula
  desc "A CLI tool for generating images of ferns 🌿 and other Iterated Function Systems"
  homepage "https://github.com/two-twelve/fernery"
  url "https://github.com/two-twelve/fernery/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "f8beffda2888eaa2645efbea2753cb388310ac2f72885c6db00c7dd33fc72a08"
  license "MIT"

  depends_on "haskell-stack" => :build
  depends_on "ghc@9.2" => :build

  def install
    stack_args = [
      "--copy-bins",
      "--local-bin-path=#{bin}",
      "--system-ghc",
    ]

    system "stack", "build", *stack_args
    system "mv", "#{bin}/fernery-exe", "#{bin}/fernery"
  end

  test do
    system "fernery", "-f", "barnsley"
    assert_predicate testpath/"fern.png", :exist?
  end
end
