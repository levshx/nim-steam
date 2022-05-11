# Package

version       = "0.0.2"
author        = "levshx"
description   = "Steam library"
license       = "MIT License"

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
  exec "nim doc --project --index:on --git.url:https://github.com/levshx/nim-steam --git.commit:devel --outdir:docs/html steam.nim"
  exec "nim rst2html --index:on --git.url:https://github.com/levshx/nim-steam --git.commit:devel --outdir:docs/html docs/*.rst"
  exec "nim buildIndex --project -o:docs/html/index.html docs"

task webapi, "Build webapi with you API key":
  if paramCount() == 8:
    echo "Specify the steam WebAPI key parameter or use -keyless"
    echo "nimble webapi <key || -keyless>"
  elif paramStr(paramCount()) == "-keyless":
    echo "nim c -r webapibuiler "&paramStr(paramCount())