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
