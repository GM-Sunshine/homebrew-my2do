class My2do < Formula
  desc "Capture and manage your to-do list from the terminal"
  homepage "https://my2do.app"
  # Single-file bash CLI served (versioned + stamped) by the app. On each CLI
  # release, bump `version` + `sha256` with scripts/bump.sh.
  url "https://my2do.app/cli/my2do"
  version "0.1.2"
  sha256 "7be97bf53d6f947a467f1242663c524efde921afd3419b6b146a237667871e9b"

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
