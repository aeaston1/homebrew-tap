class Cupld < Formula
  desc "Local graph database CLI and REPL"
  homepage "https://github.com/aeaston1/cupld"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/aeaston1/cupld/releases/download/v0.2.0/cupld-aarch64-apple-darwin.tar.xz",
        tag: "v0.2.0"
    sha256 "d8f00ef6d5142a22d7633cecd69e7c6f9c2752e39f7f0c5e27d50efbb0e4d016"
  end

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/aeaston1/cupld/releases/download/v0.2.0/cupld-x86_64-apple-darwin.tar.xz",
        tag: "v0.2.0"
    sha256 "d4485ac42164f2946dda204ee7dbfba65365a17a37e88fd2d3f3091fdb3ddd9e"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/aeaston1/cupld/releases/download/v0.2.0/cupld-x86_64-unknown-linux-musl.tar.xz",
        tag: "v0.2.0"
    sha256 "660fd6a92b945aae70f0c2c5acda7483af5367afe85633ff6db7cecdd7589477"
  end
  license "MIT"

  def install
    bin.install "cupld"

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
