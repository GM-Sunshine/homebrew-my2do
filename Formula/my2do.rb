class My2do < Formula
  desc "Capture and manage your to-do list from the terminal"
  homepage "https://my2do.app"
  # Single-file bash CLI served (versioned + stamped) by the app. On each CLI
  # release, bump `version` + `sha256` with scripts/bump.sh.
  url "https://my2do.app/cli/my2do"
  version "0.1.1"
  sha256 "6aa7c87f6f7a473d64eae4547218dcf56b078d33ab4c5c48319c8b30b6d2e381"

  # Works on macOS and Linux (Homebrew on Linux). curl is already present on
  # both; jq gives the CLI clean JSON (it falls back to python3, but jq is the
  # happy path).
  depends_on "jq"

  def install
    bin.install "my2do"
  end

  test do
    assert_match "my2do #{version}", shell_output("#{bin}/my2do --version")
  end
end
