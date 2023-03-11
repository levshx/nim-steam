# Package

version       = "0.0.2"
author        = "levshx"
description   = "Steam library"
license       = "MIT License"
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
    exec "nim c -r tester unittests::*"

task docs, "Generate docs!":
  exec "nim doc --project --index:on --git.url:https://github.com/levshx/nim-steam --git.commit:devel --outdir:docs/html src/steam.nim"
  exec "nim rst2html --index:on --git.url:https://github.com/levshx/nim-steam --git.commit:devel --outdir:docs/html docs/*.rst"
  exec "nim buildIndex --project -o:docs/html/index.html docs"

task webapi, "Build webapi without API key":
  exec "nim c -r webapibuilder.nim -keyless"
