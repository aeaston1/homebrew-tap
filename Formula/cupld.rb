class Cupld < Formula
  desc "Local graph database CLI and REPL"
  homepage "https://github.com/aeaston1/cupld"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/aeaston1/cupld/releases/download/v0.3.0/cupld-aarch64-apple-darwin.tar.xz",
        tag: "v0.3.0"
    sha256 "2888166f8e673b206abf4697f57669a17640d83d06809360a16b3516e91d5eb1"
  end

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/aeaston1/cupld/releases/download/v0.3.0/cupld-x86_64-apple-darwin.tar.xz",
        tag: "v0.3.0"
    sha256 "84c372dae8eb4ddea6c16e80e51f9c8ba69434b3c34473479c0241a1a14502e5"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/aeaston1/cupld/releases/download/v0.3.0/cupld-x86_64-unknown-linux-musl.tar.xz",
        tag: "v0.3.0"
    sha256 "ed979fdf491bd5e0cfdd8ccb0d9f2fec97669ac1ea08e772a4e407679130f86b"
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
