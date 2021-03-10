# Give your project a name. :)

workspace(name = "YOUR_PROJECT_NAME_HERE")

# Load the repository rule to download an http archive.
load(
    "@bazel_tools//tools/build_defs/repo:http.bzl",
    "http_archive"
)

# Download rules_haskell and make it accessible as "@rules_haskell".
http_archive(
    name = "rules_haskell",
    strip_prefix = "rules_haskell-60ed30aab00e9ffa2e2fe19e59f7de885f029556",
    urls = ["https://github.com/tweag/rules_haskell/archive/60ed30aab00e9ffa2e2fe19e59f7de885f029556.tar.gz"],
    sha256 = "a9c94b1fb61e1e341b7544305e9b0a359594779f797fddfcfcd447709c7c9820",
)

load(
    "@rules_haskell//haskell:repositories.bzl",
    "rules_haskell_dependencies",
)

# Setup all Bazel dependencies required by rules_haskell.
rules_haskell_dependencies()

load(
    "@rules_haskell//haskell:toolchain.bzl",
    "rules_haskell_toolchains",
)

load(
    "@rules_haskell//haskell:cabal.bzl",
    "stack_snapshot"
)

stack_snapshot(
    name = "stackage",
    extra_deps = {"zlib": ["@zlib.dev//:zlib"]},
    packages = ["zlib"],
    # Last snapshot published for ghc-8.6.5 the default version picked up by
    # rules_haskell
    snapshot = "lts-14.27",
    # This uses an unpinned version of stack_snapshot, meaning that stack is invoked on every build.
    # To switch to pinned stackage dependencies, run `bazel run @stackage-unpinned//:pin` and
    # uncomment the following line.
    # stack_snapshot_json = "//:stackage_snapshot.json",
)

# Load nixpkgs_git_repository from rules_nixpkgs,
# which was already initialized by rules_haskell_dependencies above.
load(
    "@io_tweag_rules_nixpkgs//nixpkgs:nixpkgs.bzl",
    "nixpkgs_git_repository",
    "nixpkgs_package",
    "nixpkgs_python_configure",
)

nixpkgs_python_configure(
    repository = "@nixpkgs",
)

# Fetch a version of nixpkgs from GitHub.
# For more information see the documentation of rules_nixpkgs at
# https://github.com/tweag/rules_nixpkgs/blob/master/README.md
nixpkgs_git_repository(
    name = "nixpkgs",
    revision = "772406c2a4e22a85620854056a4cd02856fa10f0",
    sha256 = "4e3429bc83182b4dc49a554a44067bd9453bd6c0827b08948b324d8a4bb3dea3",
    # sha256 = …
)

load(
    "@rules_haskell//haskell:nixpkgs.bzl",
    "haskell_register_ghc_nixpkgs",
)

# Fetch a GHC binary distribution from nixpkgs and register it as a toolchain.
# For more information:
# https://api.haskell.build/haskell/nixpkgs.html#haskell_register_ghc_nixpkgs
haskell_register_ghc_nixpkgs(
    repository = "@nixpkgs",
    attribute_path = "haskell.compiler.ghc8103",
    version = "8.10.3",
)

# For zlib.BUILD.bazel
nixpkgs_package(
    name = "nixpkgs_zlib",
    attribute_path = "zlib",
    repository = "@nixpkgs",
)

nixpkgs_package(
    name = "zlib.dev",
    build_file = "//:zlib.BUILD.bazel",
    repository = "@nixpkgs",
)
