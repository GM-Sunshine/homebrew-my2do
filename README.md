# My2Do Homebrew tap

Install the [My2Do](https://my2do.app) CLI with Homebrew:

```sh
brew install gm-sunshine/my2do/my2do
# or:
brew tap gm-sunshine/my2do
brew install my2do
```

Then:

```sh
my2do login
my2do "ship the proposal tomorrow 5pm #Work p1"
my2do ls
```

The CLI is a single self-contained bash script (needs `curl`; `jq` is installed
as a dependency for clean JSON). It talks to `https://my2do.app` by default —
override with `MY2DO_API` for a self-hosted instance.

---

## Publishing this tap (one-time — maintainer)

Homebrew maps `brew tap gm-sunshine/my2do` to the GitHub repo
`github.com/GM-Sunshine/homebrew-my2do`. So:

1. Create a **public** repo named exactly **`homebrew-my2do`** under the GM-Sunshine account.
2. Push this directory to it:

   ```sh
   cd homebrew-my2do
   git init && git add . && git commit -m "my2do 0.1.1"
   git branch -M main
   git remote add origin git@github.com:GM-Sunshine/homebrew-my2do.git
   git push -u origin main
   ```

3. Verify end-to-end on a clean machine:

   ```sh
   brew install gm-sunshine/my2do/my2do
   my2do --version   # → my2do 0.1.1
   ```

## Releasing a new CLI version

The formula pins the CLI's `version` + `sha256`. After you deploy a new CLI
(bump `CLI_VERSION` and the script in the app), update the tap:

```sh
scripts/bump.sh      # fetches the live script, updates version + sha256
git commit -am "my2do <new-version>" && git push
```

Existing users get it with `brew upgrade`.

> Note: the formula pins the sha of the script served at `/cli/my2do`. If you
> change the served script without running `bump.sh`, new installs will fail the
> checksum until the tap is bumped — so bump the tap as part of every CLI release.
> For a fully immutable artifact later, switch `url` to a GitHub release asset.
