class Cupld < Formula
  desc "Local graph database CLI and REPL."
  homepage "https://github.com/aeaston1/cupld"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/aeaston1/cupld/releases/download/v0.4.0/cupld-aarch64-apple-darwin.tar.xz"
      sha256 "d6fbaa2eaf53763c3832eea488b362636ea2c405c48fe966a8d4c034100b2bb1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/aeaston1/cupld/releases/download/v0.4.0/cupld-x86_64-apple-darwin.tar.xz"
      sha256 "48c3a6ba4fa8d0cc61aeb40597e1e3f0d6e30b16b4c3c25eaca68c34e90dcded"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/aeaston1/cupld/releases/download/v0.4.0/cupld-x86_64-unknown-linux-musl.tar.xz"
    sha256 "7fedeb0c534f65d449d1a56d6d456d767551b3f2b5046593e960a726331d8b9f"
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":              {},
    "x86_64-apple-darwin":               {},
    "x86_64-pc-windows-gnu":             {},
    "x86_64-unknown-linux-gnu":          {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "cupld" if OS.mac? && Hardware::CPU.arm?
    bin.install "cupld" if OS.mac? && Hardware::CPU.intel?
    bin.install "cupld" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
  test do
    assert_match "local graph database CLI and REPL", shell_output("#{bin}/cupld --help")
  end
end
