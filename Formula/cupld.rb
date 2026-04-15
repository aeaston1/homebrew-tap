class Cupld < Formula
  desc "Local graph database CLI and REPL."
  homepage "https://github.com/aeaston1/cupld"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/aeaston1/cupld/releases/download/v0.1.0/cupld-aarch64-apple-darwin.tar.xz"
      sha256 "2bbbf11f58eb2b9f6526d85e505fd962b5813443c8ee909e01e550e87db4d592"
    end
    if Hardware::CPU.intel?
      url "https://github.com/aeaston1/cupld/releases/download/v0.1.0/cupld-x86_64-apple-darwin.tar.xz"
      sha256 "9335c8e7003b516f24904802cea749fff7e9496285ddb58ba0451429aab93678"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/aeaston1/cupld/releases/download/v0.1.0/cupld-x86_64-unknown-linux-musl.tar.xz"
      sha256 "0b20f53014656b6599014e484ebbb8d96ad552a9995f2dd62c4cf607e91360dd"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "x86_64-apple-darwin": {},
    "x86_64-pc-windows-gnu": {},
    "x86_64-unknown-linux-gnu": {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static": {}
  }

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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "cupld"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "cupld"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "cupld"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
