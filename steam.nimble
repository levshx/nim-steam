# Package

version       = "0.0.1"
author        = "levshx"
description   = "Steam library"
license       = "GNU GENERAL PUBLIC LICENSE"
srcDir        = "src"

# Dependencies

requires "nim >= 1.6.0"
requires "bigints == 1.0.0"

when defined(nimdistros):
  import distros
  if detectOs(Ubuntu):
    foreignDep "libssl-dev"
  else:
    foreignDep "openssl"

task test, "Run the Nimble tester!":
  withDir "tests":
    exec "nim c -r tester"


task docs, "Generate docs!":
  withDir "src":
    exec "nim doc --project --index:on --git.url:https://github.com/levshx/nim-steam --git.commit:a090000 --outdir:../docs steam.nim"
  exec "nim buildIndex -o:docs/index.html docs"